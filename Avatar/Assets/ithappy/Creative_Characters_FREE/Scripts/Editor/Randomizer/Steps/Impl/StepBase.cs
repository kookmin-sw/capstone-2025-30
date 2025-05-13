using System.Linq;

namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public abstract class StepBase : IRandomizerStep
    {
        public abstract GroupType GroupType { get; }

        protected virtual float Probability => .35f;

        public abstract StepResult Process(int count, GroupType[] groups);

        protected GroupType[] RemoveSelf(GroupType[] groups)
        {
            return groups.Where(g => g != GroupType).ToArray();
        }
    }
}