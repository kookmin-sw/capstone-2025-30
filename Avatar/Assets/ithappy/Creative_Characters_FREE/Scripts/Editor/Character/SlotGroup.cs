namespace CharacterCustomizationTool.Editor.Character
{
    public class SlotGroup
    {
        public readonly GroupType Type;
        public readonly SlotVariant[] Variants;

        public SlotGroup(GroupType type, SlotVariant[] variants)
        {
            Type = type;
            Variants = variants;
        }
    }
}