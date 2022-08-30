# Gamepedia  

### 앱 소개/특징
#### NewGameView / RatingGameView
* [API](https://rawg.io/apidocs)통신을 통해 게임의 목록을 보여준다.
* 탭바 컨트롤러를 활용해 신작 게임/인기 게임을  볼 수 있다.
* 찾는 게임이 보이지 않을 경우 검색하여 찾아볼 수 있다. -> 푸쉬 후 새로운 뷰에서 검색?
* 특정 플랫폼의 게임만 모아볼 수 있도록 필터링이 가능하며 해당 옵션의 적용 여부는 네비게이션 바 타이틀로 확인할 수 있다.
* UserDefaults를 통해 사용자가 마지막으로 설정한 플랫폼/정렬 옵션을 유지한다.
#### DetailView (+WebView)
* 셀을 선택하면 세부 화면으로 이동하며, 게임의 세부 정보를 보여준다.
* 웹뷰로 연결할 수 있는 버튼이 있고 해당 버튼을 누르면 예고편을 볼 수 있다.
#### FavoritesView
* 탭바에 즐겨찾기 탭을 추가하고, 즐겨찾기한 게임들은 여기서 모아볼 수 있다.
* 디테일뷰에서 star 버튼을 누를 경우 토스트 메세지를 띄우고 해당 게임의 정보가 Realm으로 저장된다.
-------------
### 앱 UI/UX
![스크린샷 2022-08-30 오후 6 37 00](https://user-images.githubusercontent.com/92143918/187403664-5744f19a-7df2-4e9b-a285-f3e101b4d6c7.png)
-------------
### 앱 기능
#### NewGameView / RatingGameView
* API 통신 ⭐️매우 중요⭐️ ---> 우선 신작 모아보기를 구현 후, 마지막에 나누기
* SearchBar 검색 - API 검색어 필터
* 모아보기 설정 - API 정렬 옵션
* 옵션 저장 - UserDefaults
* 탭바로 나누기
#### DetailView (+WebView)
* MainView로부터 정보 전달받기
* WebView로 예고편 재생
#### FavoritesView
* 탭바에 즐겨찾기 탭을 추가하고, 즐겨찾기한 게임들을 모아볼 수 있다.
**+추가하고 싶은 기능**
* 다국어 지원 (한영일)
* 날짜 옵션 추가 (최근 한달, 1년, 5년, 10년)
-------------

### 개발 공수
| 회차 | 내용 | 세부내용 | 예상시간 | 특이사항 | 날짜 |
| --- | --- | --- | --- | --- | --- |
| **Iteration 1** |  |  |  |  | **~2022.09.11** |
|  | NewGameView | Code Base 레이아웃 | 2h |  |  |
|  | NewGameView | 오픈API 통신 | 5h |  |  |
|  | NewGameView | 페이지네이션 구현 | 4h |  |  |
|  | UIMenu+Extensio | UIMenu+Extension 구현 | 1h |  |  |
|  | NewGameView | 플랫폼 필터 구현 | 3h |  |  |
|  |  |  |  |  |  |
| **Iteration 2** |  |  |  |  | **~2022.09.14** |
|  | NewGameView | UserDefaults로 옵션 저장 | 2h |  |  |
|  | NewGameView | 검색 기능 구현 | 4h |  |  |
|  | RatingGameView | 탭바 구현 | 1h |  |  |
|  | RatingGameView | 오픈 API 통신 | 1h |  |  |
|  | RatingGameView | NewGameView 기능 이용 | 3h |  |  |
|  |  |  |  |  |  |
| **Iteration 3** |  |  |  |  | **~2022.09.18** |
|  | DetailView | Code Base 레이아웃 | 4h |  |  |
|  | DetailView | Struct Model 구성 | 1h |  |  |
|  | DetailView | 선택된 셀의 정보 받아오기 | 3h |  |  |
|  | DetailView | 받아온 정보 뷰에 보여주기 | 1h |  |  |
|  |  |  |  |  |  |
| **Iteration 4** |  |  |  |  | **~2022.09.21** |
|  | DetailView | bannerCollectionView 구성 | 2h |  |  |
|  | DetailView | 스크린샷 bannerCollectionView에 보여주기 | 3h |  |  |
|  | DetailView | bannerCollectionView 현재 페이지/전체 페이지 명시 | 3h |  |  |
|  | DetailView | WebView로 예고편 재생 | 3h |  |  |
|  |  |  |  |  |  |
| **Iteration 5** |  |  |  |  | **~2022.09.25** |
|  | RealmModel | Realm 모델 만들기 | 1h |  |  |
|  | DetailView | 즐겨찾기 버튼 구현 (Realm 저장) | 5h |  |  |
|  | FavoritesView | Code Base 레이아웃 | 1h |  |  |
|  | FavoritesView | Realm 데이터 테이블뷰에 보여주기 | 2h |  |  |
|  | FavoritesView | 스와이프로 삭제 기능 구현 | 2h |  |  |
|  |  |  |  |  |  |
| **Iteration 6** |  |  |  |  | **~2022.09.28** |
|  | 추가 기능 | 다국어 지원 | 3h |  |  |
|  | 추가 기능 | 필터에 날짜 옵션 추가 | 5h |  |  |
|  | 추가 기능 | SettingTableView 구현 | 4h |  |  |
| **Iteration 7** |  |  |  |  | **~2022.10.02** |
|  |  | 마무리 작업 |  |  |  |
|  |  | Code-Refactoring |  |  |  |
|  |  | 버그 찾기 |  |  |  |
|  |  |  |  |  |  |
| **Iteration 8** |  |  |  |  | **~2022.10.05** |
|  |  | 출시 전 테스트 |  |  |  |
|  |  |  |  |  |  |
