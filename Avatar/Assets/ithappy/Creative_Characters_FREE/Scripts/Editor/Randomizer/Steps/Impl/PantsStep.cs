namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class PantsStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.Pants;

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
    }
}