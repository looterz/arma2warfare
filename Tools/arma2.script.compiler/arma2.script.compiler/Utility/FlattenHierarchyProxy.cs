﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Reflection;

namespace ArmA2.Script.ScriptProcessor
{
    internal sealed class Flatten
    {
        [DebuggerDisplay("{Value}", Name = "{Name,nq}", Type = "{Type.ToString(),nq}")]
        internal struct Member
        {
            internal string Name;
            internal object Value;
            internal Type Type;
            internal Member(string name, object value, Type type)
            {
                Name = name;
                Value = value;
                Type = type;
            }
        }

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private readonly object _target;
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private Member[] _memberList;

        [DebuggerBrowsable(DebuggerBrowsableState.RootHidden)]
        internal Member[] Items
        {
            get
            {
                if (_memberList == null)
                {
                    _memberList = BuildMemberList().ToArray();
                }
                return _memberList;
            }
        }

        internal Flatten(object target)
        {
            _target = target;
        }

        private List<Member> BuildMemberList()
        {
            var list = new List<Member>();
            if (_target == null)
            {
                return list;
            }

            var flags = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance;
            var type = _target.GetType();
            foreach (var field in type.GetFields(flags))
            {
                var value = field.GetValue(_target);

                if (!field.FieldType.IsSubclassOf(typeof(IEnumerable)))
                    list.Add(new Member(field.Name, value, field.FieldType));
            }

            foreach (var prop in type.GetProperties(flags))
            {
                object value = null;
                try
                {
                    value = prop.GetValue(_target, null);
                }
                catch (Exception ex)
                {
                    value = ex;
                }

                if (!prop.PropertyType.IsSubclassOf(typeof(IEnumerable)))
                    list.Add(new Member(prop.Name, value, prop.PropertyType));
            }

            return list;
        }
    }
}