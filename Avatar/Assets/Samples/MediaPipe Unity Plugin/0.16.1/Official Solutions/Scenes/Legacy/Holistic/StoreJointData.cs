using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;

public class StoreJointData : MonoBehaviour
{
    private Vector3[] trackJoint = new Vector3[13];
    private Vector3[] lhtrackJoint = new Vector3[21];
    private Vector3[] rhtrackJoint = new Vector3[21];
    private Vector3[] facetrackJoint = new Vector3[468];

    public List<AvatarData> limbsJointData;
    public List<AvatarData> faceJointData;
    public List<AvatarData> handsJointData;
    public Dictionary<string, AvatarData> torsoJointData;
    public Animator anim;

    private Vector3 virtualNeck;
    private Vector3 virtualHips;
    private Vector3 virtualUpperChest;
    private Vector3 virtualHead;
    private Vector3 virtualMouth;

    private Vector3 virtualLeftThumb;
    private Vector3 virtualLeftIndex;
    private Vector3 virtualLeftMiddle;
    private Vector3 virtualLeftRing;
    private Vector3 virtualLeftPinky;

    private Vector3 fixedHipsPosition;

    private void Start()
    {
        fixedHipsPosition = anim.GetBoneTransform(HumanBodyBones.Hips).position;
    }


    private void Awake()
    {
        limbsJointData = new List<AvatarData>();
        handsJointData = new List<AvatarData>();
        torsoJointData = new Dictionary<string, AvatarData>();
        trackJoint = new Vector3[13]; // 배열 크기 명시적 초기화
        lhtrackJoint = new Vector3[13]; // 배열 크기 명시적 초기화
        rhtrackJoint = new Vector3[13]; // 배열 크기 명시적 초기화
        facetrackJoint = new Vector3[468];
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
        virtualHips.y -= 0.05f;
    
        // 3. 상체(virtualUpperChest) 계산
        virtualUpperChest = (trackJoint[1] + trackJoint[2]) / 2.0f;
        virtualUpperChest.y -= 0.1f;
        
        // 4. 입 중앙(virtualMouth) 계산
        virtualMouth = (facetrackJoint[9] + facetrackJoint[8]) / 2.0f;
        virtualMouth.y += 0.05f;
        
        // 5. 머리(virtualHead) 계산
        virtualHead = (virtualNeck + virtualMouth) / 2.0f;
        virtualHead.y += 0.075f;

        // 4. 엉덩이 위치 적용 (Null 체크 추가)
        //Transform hipsBone = anim.GetBoneTransform(HumanBodyBones.Hips);
        //if (hipsBone != null)
        //    hipsBone.position = virtualHips;
        //for (int i = 0; i < 13; i++)
        //    {
        //    trackJoint[i].y *= -1f; // 트래킹한 조인트 값의 y좌표가 땅과 반대로 되어있음
        //    trackJoint[i] += virtualHips; // pose_world_landmarks는 엉덩이 중간 포인트를 기준으로 상대좌표이므로 Hips의 위치를 더해 절대 좌표를 구해준다.
        //    }
            
        anim.GetBoneTransform(HumanBodyBones.Hips).position = fixedHipsPosition;
    }
    


    public void SetTrackJointData(Vector3[] realJoint, Vector3[] realRightHandJoint, Vector3[] realLeftHandJoint, Vector3[] realFaceJoint)
    {
        trackJoint = realJoint;
        lhtrackJoint = realLeftHandJoint;
        rhtrackJoint = realRightHandJoint;
        facetrackJoint = realFaceJoint;
    }

    public void AddLimbsJointData(HumanBodyBones parent, HumanBodyBones child, Vector3 trackParent, Vector3 trackChild)
    {
        limbsJointData.Add(new AvatarData(anim.GetBoneTransform(parent), anim.GetBoneTransform(child), trackParent, trackChild));
    }
    
    public void AddHandsJointData(HumanBodyBones parent, HumanBodyBones child, Vector3 trackParent, Vector3 trackChild)
    {
        handsJointData.Add(new AvatarData(anim.GetBoneTransform(parent), anim.GetBoneTransform(child), trackParent, trackChild));
    }
    // public void AddLimbsJointData(HumanBodyBones parent, HumanBodyBones child, Vector3 trackParent, Vector3 trackChild)
    // {
    //     Transform parentTransform = anim.GetBoneTransform(parent);
    //     Transform childTransform = anim.GetBoneTransform(child);
    //
    //     if (parentTransform != null && childTransform != null)
    //         limbsJointData.Add(new AvatarData(parentTransform, childTransform, trackParent, trackChild));
    // }

    public void AddTorsoJointData(string name, HumanBodyBones parent, HumanBodyBones child, Vector3 trackParent,
        Vector3 trackChild)
    {
        torsoJointData.Add(name,
            new AvatarData(anim.GetBoneTransform(parent), anim.GetBoneTransform(child), trackParent, trackChild));
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
        
        // LeftHand
        // AddLimbsJointData(HumanBodyBones.LeftHand, virtualLeftThumb, lhtrackJoint[0], lhtrackJoint[2]);
        AddHandsJointData(HumanBodyBones.LeftHand, HumanBodyBones.LeftThumbProximal, trackJoint[5], lhtrackJoint[1]);
        AddHandsJointData(HumanBodyBones.LeftThumbProximal, HumanBodyBones.LeftThumbIntermediate, lhtrackJoint[1], lhtrackJoint[2]);
        AddHandsJointData(HumanBodyBones.LeftThumbIntermediate, HumanBodyBones.LeftThumbDistal, lhtrackJoint[2], lhtrackJoint[3]);
        
        AddHandsJointData(HumanBodyBones.LeftHand, HumanBodyBones.LeftIndexProximal, lhtrackJoint[0], lhtrackJoint[5]);
        AddHandsJointData(HumanBodyBones.LeftIndexProximal, HumanBodyBones.LeftIndexIntermediate, lhtrackJoint[5], lhtrackJoint[6]);
        AddHandsJointData(HumanBodyBones.LeftIndexIntermediate, HumanBodyBones.LeftIndexDistal, lhtrackJoint[6], lhtrackJoint[7]);
        
        AddHandsJointData(HumanBodyBones.LeftHand, HumanBodyBones.LeftMiddleProximal, lhtrackJoint[0], lhtrackJoint[9]);
        AddHandsJointData(HumanBodyBones.LeftMiddleProximal, HumanBodyBones.LeftMiddleIntermediate, lhtrackJoint[9], lhtrackJoint[10]);
        AddHandsJointData(HumanBodyBones.LeftMiddleIntermediate, HumanBodyBones.LeftMiddleDistal, lhtrackJoint[10], lhtrackJoint[11]);

        AddHandsJointData(HumanBodyBones.LeftHand, HumanBodyBones.LeftRingProximal, lhtrackJoint[0], lhtrackJoint[13]);
        AddHandsJointData(HumanBodyBones.LeftRingProximal, HumanBodyBones.LeftRingIntermediate, lhtrackJoint[13], lhtrackJoint[14]);
        AddHandsJointData(HumanBodyBones.LeftRingIntermediate, HumanBodyBones.LeftRingDistal, lhtrackJoint[14], lhtrackJoint[15]);

        AddHandsJointData(HumanBodyBones.LeftHand, HumanBodyBones.LeftLittleProximal, lhtrackJoint[0], lhtrackJoint[17]);
        AddHandsJointData(HumanBodyBones.LeftLittleProximal, HumanBodyBones.LeftLittleIntermediate, lhtrackJoint[17], lhtrackJoint[18]);
        AddHandsJointData(HumanBodyBones.LeftLittleIntermediate, HumanBodyBones.LeftLittleDistal, lhtrackJoint[18], lhtrackJoint[19]);
        
        // RightHand
        AddHandsJointData(HumanBodyBones.RightHand, HumanBodyBones.RightThumbProximal, trackJoint[6], rhtrackJoint[1]);
        AddHandsJointData(HumanBodyBones.RightThumbProximal, HumanBodyBones.RightThumbIntermediate, rhtrackJoint[1], rhtrackJoint[2]);
        AddHandsJointData(HumanBodyBones.RightThumbIntermediate, HumanBodyBones.RightThumbDistal, rhtrackJoint[2], rhtrackJoint[3]);
        
        AddHandsJointData(HumanBodyBones.RightHand, HumanBodyBones.RightIndexProximal, rhtrackJoint[0], rhtrackJoint[5]);
        AddHandsJointData(HumanBodyBones.RightIndexProximal, HumanBodyBones.RightIndexIntermediate, rhtrackJoint[5], rhtrackJoint[6]);
        AddHandsJointData(HumanBodyBones.RightIndexIntermediate, HumanBodyBones.RightIndexDistal, rhtrackJoint[6], rhtrackJoint[7]);
        
        AddHandsJointData(HumanBodyBones.RightHand, HumanBodyBones.RightMiddleProximal, rhtrackJoint[0], rhtrackJoint[9]);
        AddHandsJointData(HumanBodyBones.RightMiddleProximal, HumanBodyBones.RightMiddleIntermediate, rhtrackJoint[9], rhtrackJoint[10]);
        AddHandsJointData(HumanBodyBones.RightMiddleIntermediate, HumanBodyBones.RightMiddleDistal, rhtrackJoint[10], rhtrackJoint[11]);

        AddHandsJointData(HumanBodyBones.RightHand, HumanBodyBones.RightRingProximal, rhtrackJoint[0], rhtrackJoint[13]);
        AddHandsJointData(HumanBodyBones.RightRingProximal, HumanBodyBones.RightRingIntermediate, rhtrackJoint[13], rhtrackJoint[14]);
        AddHandsJointData(HumanBodyBones.RightRingIntermediate, HumanBodyBones.RightRingDistal, rhtrackJoint[14], rhtrackJoint[15]);

        AddHandsJointData(HumanBodyBones.RightHand, HumanBodyBones.RightLittleProximal, rhtrackJoint[0], rhtrackJoint[17]);
        AddHandsJointData(HumanBodyBones.RightLittleProximal, HumanBodyBones.RightLittleIntermediate, rhtrackJoint[17], rhtrackJoint[18]);
        AddHandsJointData(HumanBodyBones.RightLittleIntermediate, HumanBodyBones.RightLittleDistal, rhtrackJoint[18], rhtrackJoint[19]);

        // Facial
        // AddHandsJointData(HumanBodyBones.LeftEye, HumanBodyBones.Head, facetrackJoint[1], trackJoint[0]);
        // AddHandsJointData(HumanBodyBones.RightEye, HumanBodyBones.Head, facetrackJoint[4], trackJoint[0]);



        // 몸통 데이터 저장
        AddTorsoJointData("rightHip", HumanBodyBones.Hips, HumanBodyBones.RightUpperLeg, virtualHips, trackJoint[8]);
        AddTorsoJointData("leftHip", HumanBodyBones.Hips, HumanBodyBones.LeftUpperLeg, virtualHips, trackJoint[7]);
        AddTorsoJointData("neckTwist", HumanBodyBones.Neck, HumanBodyBones.Head, virtualNeck, trackJoint[0]);
        AddTorsoJointData("rightShoulder", HumanBodyBones.UpperChest, HumanBodyBones.RightUpperArm, virtualUpperChest, trackJoint[2]);
        AddTorsoJointData("leftShoulder", HumanBodyBones.UpperChest, HumanBodyBones.LeftUpperArm, virtualUpperChest, trackJoint[1]);
        
    }
}    
