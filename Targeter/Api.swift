//
//  Api.swift
//  Targeter
//
//  Created by Apple User on 12/6/19.
//  Copyright © 2019 Alder. All rights reserved.
//

import Foundation

struct Api {
    static let user = UserApi()
    static let target = TargetApi()
    static let user_target = User_TargetApi()
    static let follow = FollowApi()
    static let feed = FeedApi()
    static let comment = CommentApi()
    static let target_comment = Target_CommentsApi()
    static let likes = LikesApi()
}
