using System;
using System.Linq;
using CharacterCustomizationTool.Editor.Character;
using CharacterCustomizationTool.Editor.Randomizer.Steps;
using CharacterCustomizationTool.Editor.Randomizer.Steps.Impl;

namespace CharacterCustomizationTool.Editor.Randomizer
{
    public class RandomCharacterGenerator
    {
        private readonly IRandomizerStep[] _randomizerSteps =
        {
            new FaceStep(),
            new BodyStep(),
            new CostumesStep(),
            new MascotsStep(),
            new OutfitStep(),
            new OutwearStep(),
            new PantsStep(),
            new ShortsStep(),
            new SocksStep(),
            new HatStep(),
            new HatSingleStep(),
            new FaceAccessoriesStep(),
            new GlassesStep(),
            new ShoesStep(),
            new HairstyleSingleStep(),
            new HairstyleStep(),
            new GlovesStep(),
        };

        public void Randomize(CustomizableCharacter character)
        {
            character.ToDefault();

            var groups = Enum.GetValues(typeof(GroupType)).Cast<GroupType>().ToArray();

            foreach (var step in _randomizerSteps)
            {
                var variantsCount = character.GetVariantsCountInGroup(step.GroupType);

                var stepResult = step.Process(variantsCount, groups);

                groups = stepResult.AvailableGroups;
                character.PickGroup(step.GroupType, stepResult.Index, stepResult.IsActive);
            }
        }
    }
}