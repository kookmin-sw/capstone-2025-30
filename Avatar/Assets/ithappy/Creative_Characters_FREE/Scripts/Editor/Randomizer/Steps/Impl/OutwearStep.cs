namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class OutwearStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.Outwear;

        protected override GroupType[] CompatibleGroups => new[]
        {
            GroupType.Pants,
            GroupType.Shorts,
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