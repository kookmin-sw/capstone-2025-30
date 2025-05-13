using System.Linq;
using UnityEngine;

namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class FaceStep : IRandomizerStep
    {
        public GroupType GroupType => GroupType.Faces;

        public StepResult Process(int count, GroupType[] groups)
        {
            var newGroups = groups.Where(g => g != GroupType.Faces).ToArray();

            return new StepResult(Random.Range(0, count), true, newGroups);
        }
    }
}