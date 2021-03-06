//
//  configs.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/23/20.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width;
let SCREEN_HEIGHT = UIScreen.main.bounds.height;

let EncryptionKey:String = "MyD0mingOL4dy-9902aF5y-F0r2D4ys4ndSom3Minutes-jEr8y2u66q-9O0fTh3m";
let AuthorizationKey:String =
    "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiYmUxNTkwNThmNmU2OTRmNDQ0OGFjNjIxNDc4ODE5ZGFmZjIxNTA4YmFkNTkxNmJlYWIzZGU4OWYwMTIwZjY3Y2Q2OGMwNDhhYmE0YzI3YzgiLCJpYXQiOjE2MDEzMTY4MTQsIm5iZiI6MTYwMTMxNjgxNCwiZXhwIjoxNjMyODUyODE0LCJzdWIiOiI0MTIyMDAyIiwic2NvcGVzIjpbXX0.GgGaW541QdmxT8Ar5tFGmA6OHCao0Jq30F6veEApbzZjLiEa3GmoZ0cy0A7CwPA_nhISF9mK7pQetQNjShODdL5OT2oh19qZSUFyVJugUo_MpFO-K0hD97vptDnyrjzKGmeUNiL-1zP3wSRGoPXwZmo37PWtfoJBZMoNZhhK9vxsyEYAo45KsndhQCQ0_0c1lM1lMoQCcPZnlxLbsnB60Ux47CLl9snDfRwJXbllu_JUc5dxi0hUhiq78mt_6KIXMV1AlHz7N5aaHLVUHOgXifZ63LtOd8GzQmbJ3iaC_lFOWz7g5uz-BxXuyGdjwrxxhGE9L18pcDjPDVcCyWXDZfT7sxIPxlzowkDEhgJoMxxyQ8krBjWp3FfpiSwwvWd9ttXh9TbfURwX84kFDW2dOU8zNoAEX9W_oWr-696gDrby-KUMkn_dvbbEvY7llOjMfzIdtHOR_WqW9Z5NBPlYmR1XThwmkZOSZn84dDeN2N_noFP4X6tz74LNwLIzAY0mcP44rZGBM6AQ7kYxlyo3JL2JgSiQfiEaF765BVDZufd5oFMeF4thV7OD4N80Pz2oUU4USNZbXN6KqA9oQkTKHeljAbf_XTXByjTiaWLs9JQQ372rn_DMBfYzKMOMULdz3v4lIVLWB8oTe1f-N1nj9btvJLmevf58tKM1w9Pc30M";

let USER_ID = "4122002";
let STATUS_BAR_Hight = UIApplication.shared.statusBarFrame.height;
let NAVI_BAR_HEIGHT = BaseNavigationController().navigationBar.bounds.height;
let TAB_BAR_HEIGHT = BaseTabBarController().tabBar.bounds.height;
let CATEGORY_BAR_HEIGHT:CGFloat = 40.0;
let BAR_HEIGHT_EX_TAB = STATUS_BAR_Hight + NAVI_BAR_HEIGHT + CATEGORY_BAR_HEIGHT
let BAR_HEIGHT = STATUS_BAR_Hight + NAVI_BAR_HEIGHT + TAB_BAR_HEIGHT + CATEGORY_BAR_HEIGHT;

let IMAGE_BROWSER_HEIGHT:CGFloat = 230.0;
let page_limited:Int = 50;
let Video_WH_Ratio: CGFloat = 16.0/9.0
let VideoPlayer_HEIGHT = SCREEN_WIDTH / Video_WH_Ratio;


// MARK:- Notification

let NOTIFICATION_FOOTER_REFRESH = "NOTIFICATION_FOOTER_REFRESH";



// MARK:- UserDefault Keys

let AV_AUDIORECORD_PERMISSION_KEY = "AV_AUDIORECORD_PERMISSION_KEY"
