//
//  ContentView.swift
//  network_n
//
//  Created by 나예은 on 2024/05/14.
//

import SwiftUI

///1. 서버에 데이터 요청
///
///
///2. 데이터를 받아옴 ( json)
///3. 데이터를 파싱한다
///4. 파싱한 데이터로 화면을 그린다.

///데이터를 받아올 틀 만들기
struct Article: Decodable {
    let id: Int
    let title,content,createdAt,updatedAt: String
    let userID: Int
    
    //JSON의 키와 Swift의 프로퍼티명이 다를 수 있습니다. 이때 CodingKeys 열거형을 사용하여 JSON 키와 Swift 프로퍼티를 명시적으로 매핑
    //JSON의 키가 "UserId"이지만 Swift 구조체에서는 userID로 사용하고 싶은 경우에 이러한 매핑을 설정
    enum CodingKeys: String, CodingKey {
        case id, title,content,createdAt,updatedAt
        case userID = "UserId"
    }
}

let dummyData = """
{
  "id": 1,
  "title": "정당의 목적이나 활동이 민주적 기본질서에 위배될 때에는 정부는 헌법재판소에 그 해산을 제소할 수 있고, 정당은 헌법재판소의 심판에 의하여 해산된다.",
  "content": "모든 국민은 인간으로서의 존엄과 가치를 가지며, 행복을 추구할 권리를 가진다. 모든 국민은 종교의 자유를 가진다. 국가는 농·어민과 중소기업의 자조조직을 육성하여야 하며, 그 자율적 활동과 발전을 보장한다. 모든 국민은 양심의 자유를 가진다. 누구든지 체포 또는 구속을 당한 때에는 즉시 변호인의 조력을 받을 권리를 가진다.",
  "createdAt": "2019-02-24T16:17:47.000Z",
  "updatedAt": "2019-02-24T16:17:47.000Z",
  "UserId": 1
}
"""

struct ContentView: View {
    
    @State var data: [String] = ["Leeo", "Ok"]
    
    var body: some View {
        VStack {
            List{
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            
            Button{
                requestData()
            } label: {
                Text("Request")
            }
        }
    }
    
    private func requestData() {
        do {
            let decodedResponse = try JSONDecoder().decode(Article.self, from: dummyData.data(using: .utf8)!)
            data.append(decodedResponse.title)
        } catch {
            print(error)
        }
    }
}

#Preview {
    ContentView()
}
