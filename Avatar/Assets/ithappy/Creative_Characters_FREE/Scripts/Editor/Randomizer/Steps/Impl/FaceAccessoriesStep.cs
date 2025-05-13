namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class FaceAccessoriesStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.FaceAccessories;

        protected override GroupType[] CompatibleGroups => new[]
        {
            GroupType.Glasses,
            GroupType.Shoes,
            GroupType.HairstyleSingle,
            GroupType.Hairstyle,
            GroupType.Gloves,
        };
    }
}