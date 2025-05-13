using System;
using Random = UnityEngine.Random;

namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class CostumesStep : StepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.Costumes;

        protected override float Probability => .2f;

        public override StepResult Process(int count, GroupType[] groups)
        {
            if (Random.value > Probability)
            {
                return new StepResult(0, false, RemoveSelf(groups));
            }

            return new StepResult(Random.Range(0, count), true, Array.Empty<GroupType>());
        }
    }
}