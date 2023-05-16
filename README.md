# What is 'Gramming'?

  * 베이킹할 때 중량 계산, 분할 등에 도움을 주는 앱입니다.
  * 메뉴 - 레시피 의 구조로 구성되어 있습니다
  * 각 레시피를 읽기, 작성, 수정, 삭제할 수 있습니다
  * 각 레시피에 기록된 중량을 곱하기, 나누기 연산하여 직관적으로 확인할 수 있습니다
  * 간단한 메모를 작성할 수 있습니다
  * 한글과 영어 양 언어로 제공됩니다

<br>
<br>

## **디자인**  

  - **아이콘 / 스플래쉬 스크린**

    <img src="https://user-images.githubusercontent.com/81023768/235719934-ccc1e86c-421e-44a8-8c3d-7c32699c276f.png" height="243px" width="243px">
    <img src="https://user-images.githubusercontent.com/81023768/235721088-5bca7d7c-051c-4cef-a808-84112994d331.png" height="508px" width="243px">  
    
    <br>  

  - **회원가입 / 로그인**

    <img src="https://user-images.githubusercontent.com/81023768/235721695-34d7cfe5-aae6-4269-b886-4d43e307518f.png" height="508px" width="243px">
    <img src="https://user-images.githubusercontent.com/81023768/235721688-bb3d204c-2537-4521-bbd9-80451d2132ba.png" height="508px" width="243px">  
    
    <br>  


  - **메뉴 + (추가/수정/삭제)**

    <img src="https://user-images.githubusercontent.com/81023768/235721918-2a08e70c-5b93-44a7-83cf-b5ac0600062e.png" height="508px" width="243px">
    <img src="https://user-images.githubusercontent.com/81023768/235721922-bc3e1ff9-fd5c-41fb-8811-c471830cf42a.png" height="508px" width="243px">
    <br>
    <img src="https://user-images.githubusercontent.com/81023768/235721932-a7cf5305-2278-4004-bb10-bab59bc6ed3c.png" height="508px" width="243px">
    <img src="https://user-images.githubusercontent.com/81023768/235721927-3c3f7886-7481-4475-b685-1b2852620cf6.png" height="508px" width="243px">  
    
    <br>  


  - **레시피 + (삭제 / 곱하기 / 나누기)**

    <img src="https://user-images.githubusercontent.com/81023768/235722555-1ce3f3d7-8dce-4162-a498-7e6d42977446.png" height="508px" width="243px">
    <img src="https://user-images.githubusercontent.com/81023768/235722564-ce622af2-05d7-421c-8c53-2e1613e75c0d.png" height="508px" width="243px">
    <br>
    <img src="https://user-images.githubusercontent.com/81023768/235722732-4b76bda4-391a-4c06-b3a8-ccc01a5415d4.png" height="508px" width="243px">
    <img src="https://user-images.githubusercontent.com/81023768/235722729-1a6e750a-cbf8-4e99-9e84-bbf9bb223e8b.png" height="508px" width="243px">
      
    <br>  


  - **레시피 추가, 레시피 수정**

    <img src="https://user-images.githubusercontent.com/81023768/235722558-a10f476d-8b2a-429b-b033-05432bb7725b.png" height="508px" width="243px">
    <img src="https://user-images.githubusercontent.com/81023768/235722566-7eeb726b-ed8d-4d31-85c6-5a762b6ced6c.png" height="508px" width="243px">  
    
    <br>  


  - **메모**

    <img src="https://user-images.githubusercontent.com/81023768/235722849-a142441a-9fbb-419e-9d72-abe27f83ea48.png" height="508px" width="243px">  
    
    <br>  
  

<br>
<br>

## **기술 스택**

  - `Flutter`  
  - `Firebase`


<br>
<br>


## **페이지 구조**

  ```dart
  - main.dart // (앱의 진입점(entry point) 역할을 합니다.)
    | 
    |- sign.dart // (로그인/로그아웃 페이지입니다.)
    | 
    |- menu.dart // (메뉴 페이지입니다, 연관성 있는 레시피들을 그룹화하는 역할을 합니다.)
        | 
        |- recipe.dart // (레시피 화면입니다, 레시피를 보여주고 추가, 삭제, 수정할 수 있는 기능들을 제공합니다))
            | 
            |- add_recipe.dart // (레시피 추가 페이지입니다.)
            | 
            |- edit_recipe.dart // (레시피 수정 페이지입니다.)
  ```

<br>
<br>

## **Firebase DB 구조**

  ```dart
  // (C) : Collection
  // (D) : Document
  // (F) : Field

  - (C) user
    |
    |- (D) userUid
        |
        |- (F) menuList = [menu1, menu2, menu3, menu4]
        |   |
        |   |- (C) menu1
        |   |   |
        |   |   |- (D) memo = {
        |   |   |        Memo: "Memo Example..."
        |   |   |      }
        |   |   |
        |   |   |- (D) recipeList = [
        |   |   |        recipe1, recipe2, recipe3, recipe4
        |   |   |      ]
        |   |   |
        |   |   |- (D) recipe
        |   |       |
        |   |       |- (F) recipe1 = {
        |   |       |          divideWeight : 1
        |   |       |          multipleValue : 1
        |   |       |          ingredient = [ingredient1, ingredient2, ingredient3, ...]
        |   |       |          weight = [weight1, weight2, weight3, ...]
        |   |       |       }
        |   |       |
        |   |       |  ...
        |   |
        |   |- (C)menu2
        |   |   | ...
        |   |- (C)menu3
        |   |   | ...
        |   |- (C)menu4
        |       | ...
        | ...
  ```

<br>
<br>
