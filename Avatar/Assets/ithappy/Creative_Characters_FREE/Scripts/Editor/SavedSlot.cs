namespace CharacterCustomizationTool.Editor
{
    public readonly struct SavedSlot
    {
        public readonly SlotType SlotType;
        public readonly bool IsEnabled;
        public readonly int VariantIndex;

        public SavedSlot(SlotType slotType, bool isEnabled, int variantIndex)
        {
            SlotType = slotType;
            IsEnabled = isEnabled;
            VariantIndex = variantIndex;
        }
    }
}