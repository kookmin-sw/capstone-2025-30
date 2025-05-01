using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using Mediapipe; //파일 입출력 위한 헤더 파일

public class PoseToAvatarController : MonoBehaviour
{
    public Animator anim;
    public NormalizedLandmarkList PoseLandmarkList;
    public NormalizedLandmarkList RightHandLandmarkList;
    public NormalizedLandmarkList LeftHandLandmarkList;
    public NormalizedLandmarkList FaceLandmarkList;
    StoreJointData storeData;
    MoveAvatar moveAvatar;
    Vector3[] realJoint; // 텍스트 파일에서 읽어온 x,y,z로 캐릭터 실제 position값 저장
    Vector3[] realLeftHandJoint; // 텍스트 파일에서 읽어온 x,y,z로 캐릭터 실제 position값 저장
    Vector3[] realRightHandJoint; // 텍스트 파일에서 읽어온 x,y,z로 캐릭터 실제 position값 저장
    Vector3[] realFaceJoint;
    
    [Range(0f, 200f)]
    public float poseScale = 100f;
    float screenWidth = Screen.width;
    float screenHeight = Screen.height;
    [Range(0f, 500f)]
    public float offsetX = 475.0f;
    
    [Range(0f, 1000f)]
    public float offsetY = 400.0f;
    
    [Range(0f, 500f)]
    public float offsetZ = 100.0f;
    
    // [Range(0f, 500f)]
    // public float offsetZ = 200.0f;
    public void ApplyPoseToAvatar(NormalizedLandmarkList poseLandmarkList)
    {
        this.PoseLandmarkList = poseLandmarkList;
    }
    public void ApplyFaceToAvatar(NormalizedLandmarkList faceLandmarkList)
    {
        this.FaceLandmarkList = faceLandmarkList;
    }
    public void ApplyLHandToAvatar(NormalizedLandmarkList lhandLandmarkList)
    {
        this.LeftHandLandmarkList = lhandLandmarkList;
    }
    public void ApplyRHandToAvatar(NormalizedLandmarkList rhandLandmarkList)
    {
        this.RightHandLandmarkList = rhandLandmarkList;
    }
    
    private void Start()
    {
        anim = GetComponent<Animator>();
        storeData = gameObject.AddComponent<StoreJointData>();
        storeData.InitializeAnimator(anim);
        moveAvatar = gameObject.AddComponent<MoveAvatar>();
        realJoint = new Vector3[33];
        realLeftHandJoint = new Vector3[21];
        realRightHandJoint = new Vector3[21];
        realFaceJoint = new Vector3[10];
        
    }

    private void Update()
    {
        // PoseLandmarkList가 null인지 체크
        if (PoseLandmarkList == null || PoseLandmarkList.Landmark == null) return;
        int j = 0;
        int p = 0;
        // position은 절대 좌표임
        for (int i = 0; i < 33; i++)
        {
            if (i == 0 || (i >= 11 && i <= 12) || (i >= 23 && i <= 32))
            {
                // Landmark 데이터를 trackJoint에 저장하는 코드
                realJoint[j].x = PoseLandmarkList.Landmark[i].X * screenWidth - screenWidth + offsetX;
                realJoint[j].y = -PoseLandmarkList.Landmark[i].Y * screenHeight + screenHeight;
                realJoint[j].z = PoseLandmarkList.Landmark[i].Z;
                j++;
            }
            
            if (i >= 13 && i <= 16)
            {
                // Landmark 데이터를 trackJoint에 저장하는 코드
                realJoint[j].x = PoseLandmarkList.Landmark[i].X * screenWidth - screenWidth + offsetX;
                realJoint[j].y = -PoseLandmarkList.Landmark[i].Y * screenHeight + screenHeight;
                realJoint[j].z = PoseLandmarkList.Landmark[i].Z * (screenWidth / 5);
                j++;
            }
            
            if (i >= 1 && i <= 10)
            {
                realFaceJoint[p].x = PoseLandmarkList.Landmark[i].X * screenWidth - offsetX;
                realFaceJoint[p].y = -PoseLandmarkList.Landmark[i].Y * screenHeight + offsetY;
                realFaceJoint[p].z = PoseLandmarkList.Landmark[i].Z;
                p++;
            }
            
        }
        
        int l = 0;
        // position은 절대 좌표임
        // 왼손
        for (int i = 0; i < 21; i++)
        {
            // Landmark 데이터를 trackJoint에 저장하는 코드
            realLeftHandJoint[l].x = LeftHandLandmarkList.Landmark[i].X * screenWidth - screenWidth + offsetX;
            realLeftHandJoint[l].y = -LeftHandLandmarkList.Landmark[i].Y * screenHeight + screenHeight;
            realLeftHandJoint[l].z = LeftHandLandmarkList.Landmark[i].Z;
            l++;
        }
        
        int r = 0;
        // position은 절대 좌표임
        // 오른손
        for (int i = 0; i < 21; i++)
        {
            // Landmark 데이터를 trackJoint에 저장하는 코드
            realRightHandJoint[r].x = RightHandLandmarkList.Landmark[i].X * screenWidth - offsetX;
            realRightHandJoint[r].y = -RightHandLandmarkList.Landmark[i].Y * screenHeight + offsetY;
            realRightHandJoint[r].z = RightHandLandmarkList.Landmark[i].Z;
            r++;
        }
        int f = 0;
        // position은 절대 좌표임
        // 얼굴
        // for (int i = 0; i < 21; i++)
        // {
        //     // Landmark 데이터를 trackJoint에 저장하는 코드
        //     realFaceJoint[f].x = FaceLandmarkList.Landmark[i].X * screenWidth - offsetX;
        //     realFaceJoint[f].y = -FaceLandmarkList.Landmark[i].Y * screenHeight + offsetY;
        //     realFaceJoint[f].z = FaceLandmarkList.Landmark[i].Z;
        //     f++;
        // }

        storeData.SetTrackJointData(realJoint,realLeftHandJoint,realRightHandJoint,realFaceJoint);
       
        // 아바타의 팔다리, 몸통 관절데이터 저장
        storeData.Store();

        //움직이기 위한 관절 데이터 전달
        moveAvatar.SetRequiredData(storeData.limbsJointData, storeData.handsJointData, storeData.torsoJointData);
        
        //아바타 팔다리, 몸통 움직이는 함수
        moveAvatar.MoveLimbs();
        moveAvatar.MoveTorso();
        moveAvatar.MoveHand();
  
        // 데이터 청소
        storeData.ClearAllData();
        moveAvatar.ClearAllData();
    }

}