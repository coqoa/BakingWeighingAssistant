# Gramming

- Splash Screen  
![splashScreen](https://user-images.githubusercontent.com/81023768/208288586-4ad0593c-51e5-4792-84a0-776ae3b231cb.png)  

- Sign In / Sign Up  
![signin](https://user-images.githubusercontent.com/81023768/208288596-269e2d7d-0fe4-4e7b-9297-46e6eb86ef21.png)
![signup](https://user-images.githubusercontent.com/81023768/208288597-5bd568ad-d1ca-4710-8fcb-ff6ed880d895.png)  

- Menu  
![menu](https://user-images.githubusercontent.com/81023768/208288602-f8d80177-73e1-4103-9dad-8ba06bc4f08d.png)  
![menu – create 1](https://user-images.githubusercontent.com/81023768/208288608-b7b844a1-0879-47c3-bdf7-d7a115c3d83d.png)
![menu – create 2](https://user-images.githubusercontent.com/81023768/208288609-0c69b2c9-a1fe-46da-8129-e6e90b87bebf.png)  
![menu – option](https://user-images.githubusercontent.com/81023768/208288620-ae6b2971-77a0-43ce-a8c5-e52aced94b20.png)
![menu – delete](https://user-images.githubusercontent.com/81023768/208288621-d9507b5d-4f79-42d2-8a59-9168496b0954.png)  
![menu - modify 1](https://user-images.githubusercontent.com/81023768/208288624-e4c1b8c8-699f-4395-9384-ce628d19ace5.png)
![menu - modify 2](https://user-images.githubusercontent.com/81023768/208288625-c2de0167-f1ba-469a-b18b-407d57f52296.png)  

- Main  
![main](https://user-images.githubusercontent.com/81023768/208288631-d15d69ca-2458-433d-994f-b614b6469c43.png)  
![main - memo 1](https://user-images.githubusercontent.com/81023768/208288637-21a9c3eb-b9e0-4559-82ff-2b3f81f9905e.png)
![main - memo 2](https://user-images.githubusercontent.com/81023768/208288638-1849c3c8-5022-4c3b-84c7-7a29d67e2ec6.png)  
![main - side modal](https://user-images.githubusercontent.com/81023768/208288783-804cc705-bcd3-429d-bcac-2c48e87b8273.png)
![main - multiple](https://user-images.githubusercontent.com/81023768/208288645-3e89dafb-ff04-43a8-be98-6d4e50c3feac.png)  

- Add  
![add](https://user-images.githubusercontent.com/81023768/208288657-0574444b-c6db-4073-a514-a2711c52edbb.png)  
![add - save](https://user-images.githubusercontent.com/81023768/208288664-77d5fce1-9e8b-4fa6-8f81-efce99283bcf.png)
![add - exit](https://user-images.githubusercontent.com/81023768/208288666-66ba44c1-b7d9-488a-a31c-1b6df874f7a4.png)

- Update  
![update](https://user-images.githubusercontent.com/81023768/208288673-3226095c-6575-4606-a07a-b95e241b476a.png)  
![update - save](https://user-images.githubusercontent.com/81023768/208288697-e4c3e3cb-3f4d-4dbc-9243-165465e18b5c.png)
![update - exit](https://user-images.githubusercontent.com/81023768/208288699-9e5ab955-5b47-4fcc-bd8b-53bea5e4c786.png)
![update- delete](https://user-images.githubusercontent.com/81023768/208288700-f243e56b-eb26-4e1c-9658-6d28d3923f4e.png)




  

### DB구조

- users `collection`
	- admin@admin.com `doc`
		- [recipe1, recipe2, recipe3 ...]
		- recipe collection
			- recipe1
				- [{key:value}...]
			- recipe2
				- [{key:value}...]
			- recipe3
				- [{key:value}...]
- menu page
: menu를 선택해서 main page로 이동한다

- main page
  - initState할 때 recipe list만 불러오고 리스트의 첫번 째 요소의 String를 키값으로 recipe를 찾아와서 배치한다
	- 레시피의 이름(String)을 키값으로 recipe list에서 개별 레시피를 불러오는 event를 수행한다

- add page  
: 해당 페이지의 menu list `collection`에 recipe list `doc`, recipe `doc`을 더한다

- update page  
	- ReorderableListView 위젯을 통해 recipe list를 정리할 수 있다
	- 상세 레시피 내용도 ReorderableListView 위젯을 통해 드래그앤 드롭이 가능하도록 하고 `List<Map<String, dynamic>>` 형태로  관리한다
	- 레시피 삭제 기능도 여기서 수행한다


- 공통 클래스 
	- 텍스트필드
	- 말풍선 버튼, 
	- 바텀시트 (로그인 / 로그아웃?) (=Get 사용?)
	- 다이얼로그 (= Get 사용?) 
	- 버튼(긴거, 짧은거)
- 페이지 이동시 이전 페이지 삭제하는것 / 삭제하지 않는것 구분
 
입력페이지 먼저 
