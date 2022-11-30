# Gramming
  
![splashScreen](https://user-images.githubusercontent.com/81023768/203576310-af2b0652-81cf-4eda-a8ce-c7b1c6131dd2.png)  


![signIn](https://user-images.githubusercontent.com/81023768/203576344-32aedb81-f5ef-479d-8acd-6c97a8d7994c.png)
![signUp](https://user-images.githubusercontent.com/81023768/203576359-689686c5-a29d-40ca-a82d-1199935f373e.png)  

![main-1](https://user-images.githubusercontent.com/81023768/204557162-1ef2e913-1040-4869-8029-9e687d003f19.png)
![main-1 – 1](https://user-images.githubusercontent.com/81023768/204833421-ab609257-5881-4cc8-8026-5d3bc0c9dd14.png)



![add-1 – 1](https://user-images.githubusercontent.com/81023768/204557216-a7265396-6889-4b7b-9c6c-469cc3e511eb.png)
![add-1 – 2](https://user-images.githubusercontent.com/81023768/204557225-d14e230c-719f-40f7-afb4-f0c6da5b8758.png)  

![update-1 – 3](https://user-images.githubusercontent.com/81023768/204557314-0762dedf-3f06-4f8f-8f77-0cc1db068605.png)
![update-1 – 4](https://user-images.githubusercontent.com/81023768/204557311-6e85c6cf-7d81-43ce-896f-95d7954dae54.png)
![update-1 – 5](https://user-images.githubusercontent.com/81023768/204557306-c7ee3de5-59d6-4e23-b435-c153c05c2d23.png)  


  

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


- 


