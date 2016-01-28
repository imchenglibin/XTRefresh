//
//  XTRefreshDefine.h
//  XTRefresh
//
//  Created by imchenglibin on 16/1/27.
//  Copyright © 2016年 xt. All rights reserved.
//

#ifndef XTRefreshDefine_h
#define XTRefreshDefine_h

#define XTWeakify(o) __weak typeof(self) xt_weak = o;
#define XTStrongify(o) __strong typeof(self) o = xt_weak;

#endif /* XTRefreshDefine_h */
