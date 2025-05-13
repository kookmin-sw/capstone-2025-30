namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class HairstyleSingleStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.HairstyleSingle;

        protected override GroupType[] CompatibleGroups => new[]
        {
            GroupType.Gloves,
        };
    }
}