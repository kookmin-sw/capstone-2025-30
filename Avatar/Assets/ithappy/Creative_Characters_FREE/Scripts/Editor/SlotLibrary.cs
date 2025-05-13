using System;
using UnityEngine;

namespace CharacterCustomizationTool.Editor
{
    [CreateAssetMenu(menuName = "Character Customization Tool/Slot Library", fileName = "SlotLibrary")]
    public class SlotLibrary : ScriptableObject
    {
        public FullBodyEntry[] FullBodyCostumes;
        public SlotEntry[] Slots;
    }

    [Serializable]
    public class FullBodyEntry
    {
        public FullBodySlotEntry[] Slots;
    }

    [Serializable]
    public class FullBodySlotEntry
    {
        public SlotType Type;
        public GameObject GameObject;
    }

    [Serializable]
    public class SlotEntry
    {
        public SlotType Type;
        public SlotGroupEntry[] Groups;
    }

    [Serializable]
    public class SlotGroupEntry
    {
        public GroupType Type;
        public GameObject[] Variants;
    }
}