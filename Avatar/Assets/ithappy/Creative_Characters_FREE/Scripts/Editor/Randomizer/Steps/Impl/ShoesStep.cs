namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class ShoesStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.Shoes;

        protected override GroupType[] CompatibleGroups => new[]
        {
            GroupType.HairstyleSingle,
            GroupType.Hairstyle,
            GroupType.Gloves,
        };
    }
}