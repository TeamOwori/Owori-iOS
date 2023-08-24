//
//  StorySearchView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct StorySearchView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    
    @State private var searchText: String = ""
    @State private var isExistRecentSearchList: Bool = false
    @State private var isExistSearchResult: Bool = false
    @State private var searchList: [Story.StoryInfo] = []
    
    var body: some View {
        VStack {
            HStack {
                Text("최근 검색어")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.oworiGray700)
                Spacer()
                Text("전체 삭제")
                    .foregroundColor(Color.oworiGray400)
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
            
            Spacer()
            
            //View 테스트 용도로 넣어둔 코드입니다.
//            RecentSearchList()
            
            if searchText.isEmpty {
                if isExistRecentSearchList {
                    RecentSearchList()
                } else {
                    VStack {
                        Image("Smile")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        Text("최근 검색어가 없습니다.")
                            .foregroundColor(Color.oworiGray300)
                    }
                }
            } else {
                if isExistSearchResult {
                    VStack {
                        ForEach($searchList, id: \.self) { $storyInfo in
                            //                    RecentSearchList()
                            NavigationLink {
                                // 임시 변수 삽입 -> 나중에 고치기
                                StoryDetailView(storyInfo: $storyInfo, stories: $searchList, storiesForCollection: .constant([:]), storyDetailViewIsActive: .constant(true), storyDetailViewIsActiveFromStoryAlbum: .constant(false))
                            } label: {
                                DailyStoryListCell(storyInfo: $storyInfo)
                            }
                            .foregroundColor(Color.black)
                        }
                        Spacer()
                    }
                    
                    
                } else {
                    VStack {
                        Spacer()
                        Image("Sad")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        Text("검색 결과가 없어요")
                            .foregroundColor(Color.oworiGray300)

                        Spacer()

                        VStack(alignment: .leading, spacing: 15) {
                            Text("검색이 안될 때 꿀팁!")
                                .foregroundColor(Color.oworiGray700)
                            Text("･ 검색어를 바르게 입력했는지 확인해 보세요")
                            Text("･ 짧은 단어로 검색해 보세요 (예: 동해바다 > 동해)")
                        }
                        .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
                        .foregroundColor(Color.oworiGray600)
                        .background(Color.oworiGray100)
                        .cornerRadius(10)
                    }
                }
            }
            
            Spacer()
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    TextField("추억을 검색해보세요", text: $searchText, onCommit: {
                        storyViewModel.searchStorySortByKeyword(user: userViewModel.user, keyword: searchText, completion: { searchList in
                            self.searchList = searchList
                            print("추억 검색\(self.searchList)")
                            if searchList.isEmpty {
                                isExistSearchResult = false
                            } else {
                                isExistSearchResult = true
                            }
                        })
                    })
                    .onChange(of: searchText) { newText in
                        searchList = []
                    }
                    Button {
                        searchText = ""
                        searchList = []
                    } label: {
                        if searchText.isEmpty {
                            EmptyView()
                        } else {
                            Image("Close")
                        }
                    }
//                    Button {
//                        Image
//                    } label: {
//
//                    }
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(Color.oworiGray100)
                .cornerRadius(10)
            }
        }
    }
}

struct StorySearchView_Previews: PreviewProvider {
    static var previews: some View {
        StorySearchView()
            .environmentObject(UserViewModel())
            .environmentObject(StoryViewModel())
    }
}

