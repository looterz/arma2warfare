using System;
using Arma2.Script.Compiler.Sqf.Attributes;
using Arma2.Script.Language.Contracts.Dtos;

namespace Arma2.Script.Language.Contracts
{
    public delegate void EventHandler();

    public interface IObject
    {
        [InlineMethod("{0} addEventHandler[{1}, {2}]")]
        int addEventHandler(string eventName, EventHandler action);

        [InlineMethod("{0} addMPEventHandler[{1}, {2}]")]
        int addMPEventHandler(string eventName, EventHandler action);

        [InlineMethod("alive {0}")]
        bool alive();

        [InlineMethod("{0} allowDamage {1}")]
        void allowDamage(bool allowDamage);

        [InlineMethod("{0} animate [{1}, {2}]")]
        void animate(string animationName, double phase);

        [InlineMethod("{0} animationPhase {1}")]
        double animationPhase(string animationName, int phase);

        [InlineMethod("{0} attachTo[{1}]")]
        void attachTo(IObject attachTo);

        [InlineMethod("{0} attachTo[{1}, {2}]")]
        void attachTo(IObject attachTo, IPosition offset);

        [InlineMethod("{0} attachTo[{1}, {2}, {3}]")]
        void attachTo(IObject attachTo, IPosition offset, string memPoint);

        [InlineMethod("boundingBox {0}")]
        IBoundingBox boundingBox();

        [InlineMethod("boundingCenter {0}")]
        IPosition boundingCenter();


    }
}