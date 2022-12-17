# Gramming

- Splash Screen  
![splashScreen – 4](https://user-images.githubusercontent.com/81023768/208247116-baa732cf-f647-4da0-9fa4-04c3187bd060.png)  



- Sign In / Sign Up  
![splashScreen – 3](https://user-images.githubusercontent.com/81023768/208247125-21c1477b-186a-42dc-ab26-29b5f13d8304.png)  


- Menu  
![menu – 9](https://user-images.githubusercontent.com/81023768/208247159-c184f141-29ac-4a79-b95a-dff20f80bc9e.png)
![menu – 6](https://user-images.githubusercontent.com/81023768/208247160-1ba4caed-8871-4722-bd78-beeafa5a10c2.png)



- Main  



- Memo  
![main-1 – 3](https://user-images.githubusercontent.com/81023768/205496622-cd6e2966-f2d4-4986-9726-965904367357.png)
![main-1 – 6](https://user-images.githubusercontent.com/81023768/205496625-f49acee8-c1e1-4018-8e54-56a92fd45d31.png)  

- Add  

- Update  
  


  

### DB구조

- e-mail `collection`
	- menu 
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
	- 말풍성 버튼, 
	- 바텀시트 (로그인 / 로그아웃?) (=Get 사용?)
	- 다이얼로그 (= Get 사용?) 


