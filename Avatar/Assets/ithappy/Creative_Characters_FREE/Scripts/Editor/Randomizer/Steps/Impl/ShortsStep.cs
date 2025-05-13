using System.Linq;
using UnityEngine;

namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class ShortsStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.Shorts;

        protected override GroupType[] CompatibleGroups => new[]
        {
            GroupType.Hat,
            GroupType.HatSingle,
            GroupType.FaceAccessories,
            GroupType.Glasses,
            GroupType.Shoes,
            GroupType.HairstyleSingle,
            GroupType.Hairstyle,
            GroupType.Gloves,
        };

        public override StepResult Process(int count, GroupType[] groups)
        {
            var cannotProcess = !groups.Contains(GroupType);
            groups = RemoveSelf(groups);

            if (cannotProcess || Random.value > Probability)
            {
                return new StepResult(0, false, groups);
            }

            var newGroups = groups.Where(g => CompatibleGroups.Contains(g)).ToArray();
            var finalGroups = newGroups.ToList();
            finalGroups.Add(GroupType.Socks);

            return new StepResult(Random.Range(0, count), true, finalGroups.ToArray());
        }
    }
}