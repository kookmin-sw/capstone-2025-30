namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class HairstyleStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.Hairstyle;

        protected override GroupType[] CompatibleGroups => new[]
        {
            GroupType.Gloves,
        };
    }
}