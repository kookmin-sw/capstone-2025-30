namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class MascotsStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.Mascots;

        protected override GroupType[] CompatibleGroups => new[]
        {
            GroupType.Pants,
            GroupType.Shorts,
            GroupType.FaceAccessories,
            GroupType.Glasses,
            GroupType.Shoes,
            GroupType.Gloves,
        };
    }
}