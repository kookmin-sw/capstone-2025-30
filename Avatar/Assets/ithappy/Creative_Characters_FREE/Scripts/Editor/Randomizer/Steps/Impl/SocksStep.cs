namespace CharacterCustomizationTool.Editor.Randomizer.Steps.Impl
{
    public class SocksStep : SlotStepBase, IRandomizerStep
    {
        public override GroupType GroupType => GroupType.Socks;

        protected override float Probability => .5f;

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