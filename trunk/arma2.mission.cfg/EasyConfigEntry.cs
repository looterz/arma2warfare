using System;
using System.Collections;
using System.Collections.Generic;
using System.Dynamic;
using System.Xml;
using Mac.Arma.Config;
using System.Linq;

namespace ConsoleApplication2
{
    public class EasyConfigEntryEnumerator : IEnumerator<EasyConfigEntry>
    {
        public ConfigEntry Entry { get; private set; }
        private IEnumerator<ConfigEntry> _enumerator;

        public EasyConfigEntryEnumerator(ConfigEntry entry)
        {
            Entry = entry;
            _enumerator = ((IEnumerable<ConfigEntry>)Entry).GetEnumerator();
        }

        public void Dispose()
        {
            _enumerator.Dispose();
        }

        public bool MoveNext()
        {
            return _enumerator.MoveNext();
        }

        public void Reset()
        {
            _enumerator.Reset();
        }

        public EasyConfigEntry Current
        {
            get { return new EasyConfigEntry(_enumerator.Current); }
        }

        object IEnumerator.Current
        {
            get { return Current; }
        }
    }

    public class EasyConfigEntry : DynamicObject, IEnumerable<EasyConfigEntry>
    {
        public ConfigEntry Entry { get; private set; }

        public EasyConfigEntry(ConfigEntry entry)
        {
            Entry = entry;
        }

        public override bool TrySetMember(SetMemberBinder binder, object value)
        {
            var prop = Entry.GetType().GetProperties().FirstOrDefault(m => m.Name == binder.Name);
            if (prop != null)
            {
                prop.SetValue(Entry, value, new object[0]);
                return true;
            }

            if (Entry is IEnumerable<ConfigEntry>)
            {
                ConfigEntry entry = ((IEnumerable<ConfigEntry>)Entry).FirstOrDefault(m => m.Name.Equals(binder.Name, StringComparison.CurrentCultureIgnoreCase));

                if (value is string && entry is StringProperty)
                {
                    ((StringProperty) entry).Value = (string)value;
                    return true;
                }

                if (value is int && entry is IntProperty)
                {
                    ((IntProperty)entry).Value = (int)value;
                    return true;
                }

                if (value is double && entry is FloatProperty)
                {
                    ((FloatProperty)entry).Value = (float)value;
                    return true;
                }

            }
            return false;
        }

        public override bool TryGetMember(GetMemberBinder binder, out object result)
        {
            var prop = Entry.GetType().GetProperties().FirstOrDefault(m => m.Name == binder.Name);
            if (prop != null)
            {
                result = prop.GetValue(Entry, new object[0]);
                return true;
            }

            if (Entry is IEnumerable<ConfigEntry>)
            {
                ConfigEntry entry = ((IEnumerable<ConfigEntry>)Entry).FirstOrDefault(m => m.Name.Equals(binder.Name, StringComparison.CurrentCultureIgnoreCase));

                if (entry is ConfigProperty)
                {
                    result = ((ConfigProperty)entry).ValueAsObject();
                }
                else
                {
                    result = new EasyConfigEntry(entry);
                }
                return (entry != null);
            }
            result = null;
            return true;
        }

        public override bool TryInvokeMember(InvokeMemberBinder binder, object[] args, out object result)
        {
            if (Entry is IEnumerable<ConfigEntry>)
            {
                string name = binder.Name;
                if (args.Length > 0)
                    name = string.Format("{0}{1}", name, args[0]);

                var entity = ((IEnumerable<ConfigEntry>)Entry).FirstOrDefault(m => m.Name.Equals(name, StringComparison.CurrentCultureIgnoreCase));
                result = new EasyConfigEntry(entity);
                return (result != null);
            }
            result = null;
            return true;
        }

        public IEnumerator<EasyConfigEntry> GetEnumerator()
        {
            return new EasyConfigEntryEnumerator(Entry);
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
    }
}