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
    StoreJointData storeData;
    MoveAvatar moveAvatar;
    Vector3[] realJoint; // 텍스트 파일에서 읽어온 x,y,z로 캐릭터 실제 position값 저장
    [Range(0f, 200f)]
    public float poseScale = 100f;
    float screenWidth = Screen.width;
    float screenHeight = Screen.height;
    [Range(0f, 500f)]
    public float offsetX = 375.0f;
    
    [Range(0f, 500f)]
    public float offsetY = 170.0f;
    
    public void ApplyPoseToAvatar(NormalizedLandmarkList poseLandmarkList)
    {
        this.PoseLandmarkList = poseLandmarkList;
    }
    
    private void Start()
    {
        anim = GetComponent<Animator>();
        storeData = gameObject.AddComponent<StoreJointData>();
        storeData.InitializeAnimator(anim);
        moveAvatar = gameObject.AddComponent<MoveAvatar>();
        realJoint = new Vector3[33];
    }

    private void Update()
    {
        // PoseLandmarkList가 null인지 체크
        if (PoseLandmarkList == null || PoseLandmarkList.Landmark == null) return;
    
        int j = 0;
        // position은 절대 좌표임
        for (int i = 0; i < 33; i++)
        {
            if (i == 0 || (i >= 11 && i <= 16) || (i >= 23 && i <= 32))
            {
                // Landmark 데이터를 trackJoint에 저장하는 코드
                realJoint[j].x = PoseLandmarkList.Landmark[i].X * screenWidth - offsetX;
                realJoint[j].y = -PoseLandmarkList.Landmark[i].Y * screenHeight + offsetY;
                realJoint[j].z = PoseLandmarkList.Landmark[i].Z;
                j++;
            }
        }

        storeData.SetTrackJointData(realJoint);
       
        // 아바타의 팔다리, 몸통 관절데이터 저장
        storeData.Store();

        //움직이기 위한 관절 데이터 전달
        moveAvatar.SetRequiredData(storeData.limbsJointData, storeData.torsoJointData);
        
        //아바타 팔다리, 몸통 움직이는 함수
        moveAvatar.MoveLimbs();
        moveAvatar.MoveTorso();
  
        // 데이터 청소
        storeData.ClearAllData();
        moveAvatar.ClearAllData();
    }

}