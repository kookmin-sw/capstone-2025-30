using CharacterCustomizationTool.Editor.Character;

namespace CharacterCustomizationTool.Editor.SlotValidation
{
    public interface ISlotValidationRules
    {
        void Validate(CustomizableCharacter character, SlotType type, bool isToggled);
    }
}