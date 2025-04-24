using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;

public class StoreJointData : MonoBehaviour
{
    private Vector3[] trackJoint = new Vector3[13];
    public List<AvatarData> limbsJointData;
    public Dictionary<string, AvatarData> torsoJointData;
    public Animator anim;

    private Vector3 virtualNeck;
    private Vector3 virtualHips;
    private Vector3 virtualUpperChest;

    private void Awake()
    {
        limbsJointData = new List<AvatarData>();
        torsoJointData = new Dictionary<string, AvatarData>();
        trackJoint = new Vector3[13]; // 배열 크기 명시적 초기화
    }
    public void InitializeAnimator(Animator animator)
    {
        anim = animator;
    }
    public void ClearAllData()
    {
        limbsJointData.Clear();
        torsoJointData.Clear();
    }

    
    public void MakeVirtualData()
    {
        if (trackJoint == null || trackJoint.Length < 13) return;
    
        // 1. 목(virtualNeck) 계산
        virtualNeck = (trackJoint[1] + trackJoint[2]) / 2.0f;
        virtualNeck.y += 0.05f;
    
        // 2. 엉덩이(virtualHips) 계산 (기존 코드에 virtualHips 초기화 누락)
        virtualHips = (trackJoint[7] + trackJoint[8]) / 2.0f;
        virtualHips.y += 0.075f;
    
        // 3. 상체(virtualUpperChest) 계산
        virtualUpperChest = (trackJoint[1] + trackJoint[2]) / 2.0f;
        virtualUpperChest.y -= 0.1f;
    
        // 4. 엉덩이 위치 적용 (Null 체크 추가)
        Transform hipsBone = anim.GetBoneTransform(HumanBodyBones.Hips);
        if (hipsBone != null)
            hipsBone.position = virtualHips;
    }
    
    // 가상의 관절 만들기, 관절 위치 재조정
    // public void MakeVirtualData()
    // {
    //     // 가상의 목 관절의 위치 구하기
    //     virtualNeck = (trackJoint[1] + trackJoint[2]) / 2.0f;
    //     virtualNeck.y += 0.05f;
    //
    //     // 가상의 힙 관절의 위치 구하기
    //     virtualHips = (trackJoint[7] + trackJoint[8]) / 2.0f;
    //     virtualHips.y += 0.95f;
    //
    //     //가상의 UpperChest 관절 위치 구하기
    //     virtualUpperChest = (trackJoint[1] + trackJoint[2]) / 2.0f;
    //     virtualUpperChest.y -= 0.1f;
    //
    //     virtualNeck += virtualHips;
    //     virtualUpperChest += virtualHips;
    //
    //     // for (int i = 0; i < 13; i++)
    //     // {
    //     //     trackJoint[i].y *= -1f; // 트래킹한 조인트 값의 y좌표가 땅과 반대로 되어있음
    //     //     trackJoint[i] += virtualHips; // pose_world_landmarks는 엉덩이 중간 포인트를 기준으로 상대좌표이므로 Hips의 위치를 더해 절대 좌표를 구해준다.
    //     // }
    //
    //     anim.GetBoneTransform(HumanBodyBones.Hips).position = virtualHips;
    // }

    public void SetTrackJointData(Vector3[] realJoint)
    {
        trackJoint = realJoint;
    }

    public void AddLimbsJointData(HumanBodyBones parent, HumanBodyBones child, Vector3 trackParent, Vector3 trackChild)
    {
        limbsJointData.Add(new AvatarData(anim.GetBoneTransform(parent), anim.GetBoneTransform(child), trackParent, trackChild));
    }
    // public void AddLimbsJointData(HumanBodyBones parent, HumanBodyBones child, Vector3 trackParent, Vector3 trackChild)
    // {
    //     Transform parentTransform = anim.GetBoneTransform(parent);
    //     Transform childTransform = anim.GetBoneTransform(child);
    //
    //     if (parentTransform != null && childTransform != null)
    //         limbsJointData.Add(new AvatarData(parentTransform, childTransform, trackParent, trackChild));
    // }

    public void AddTorsoJointData(string name, HumanBodyBones parent, HumanBodyBones child, Vector3 trackParent, Vector3 trackChild)
    {
        torsoJointData.Add(name, new AvatarData(anim.GetBoneTransform(parent), anim.GetBoneTransform(child), trackParent, trackChild));
    }
    
    public void Store()
    {
        // 가상 관절 데이터 만들어서 저장 -> 트래킹하지 않는 관절이 있음
        MakeVirtualData();

        //팔다리 관절 데이터 저장
        AddLimbsJointData(HumanBodyBones.RightUpperArm, HumanBodyBones.RightLowerArm, trackJoint[2], trackJoint[4]);
        AddLimbsJointData(HumanBodyBones.RightLowerArm, HumanBodyBones.RightHand, trackJoint[4], trackJoint[6]);

        AddLimbsJointData(HumanBodyBones.LeftUpperArm, HumanBodyBones.LeftLowerArm, trackJoint[1], trackJoint[3]);
        AddLimbsJointData(HumanBodyBones.LeftLowerArm, HumanBodyBones.LeftHand, trackJoint[3], trackJoint[5]);

        AddLimbsJointData(HumanBodyBones.RightUpperLeg, HumanBodyBones.RightLowerLeg, trackJoint[8], trackJoint[10]);
        AddLimbsJointData(HumanBodyBones.RightLowerLeg, HumanBodyBones.RightFoot, trackJoint[10], trackJoint[12]);

        AddLimbsJointData(HumanBodyBones.LeftUpperLeg, HumanBodyBones.LeftLowerLeg, trackJoint[7], trackJoint[9]);
        AddLimbsJointData(HumanBodyBones.LeftLowerLeg, HumanBodyBones.LeftFoot, trackJoint[9], trackJoint[11]);


        // 몸통 데이터 저장
        AddTorsoJointData("rightHip", HumanBodyBones.Hips, HumanBodyBones.RightUpperLeg, virtualHips, trackJoint[8]);
        AddTorsoJointData("leftHip", HumanBodyBones.Hips, HumanBodyBones.LeftUpperLeg, virtualHips, trackJoint[7]);
        AddTorsoJointData("neckTwist", HumanBodyBones.Neck, HumanBodyBones.Head, virtualNeck, trackJoint[0]);
        AddTorsoJointData("rightShoulder", HumanBodyBones.UpperChest, HumanBodyBones.RightUpperArm, virtualUpperChest, trackJoint[2]);
        AddTorsoJointData("leftShoulder", HumanBodyBones.UpperChest, HumanBodyBones.LeftUpperArm, virtualUpperChest, trackJoint[1]);
    }
}    
