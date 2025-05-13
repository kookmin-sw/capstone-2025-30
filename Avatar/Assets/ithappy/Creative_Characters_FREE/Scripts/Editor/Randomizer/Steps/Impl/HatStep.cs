namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class HatStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.Hat;

        protected override GroupType[] CompatibleGroups => new[]
        {
            GroupType.FaceAccessories,
            GroupType.Glasses,
            GroupType.Shoes,
            GroupType.Gloves,
        };
    }
}