// AppRating.swift
//
// Copyright (c) 2017 GrizzlyNT (https://github.com/grizzly/AppRating)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

open class AppShare {
    
    var applinkCode : String?;
    
    /**
     * MARK: -
     * MARK: Initialization
     * set the applink.co Code, as received on
     * https://applink.co
     *
     * - Parameter applinkCode: your applink.co code
     */
    public init(applinkCode: String, vc:UIViewController) {
        self.applinkCode(applinkCode);
        self.manager.vc = vc;
    }
    
    /**
     * Singleton instance of the underlaying share manager.
     */
    let manager : AppShareManager = {
        struct Singleton {
            static let instance: AppShareManager = AppShareManager();
        }
        return Singleton.instance;
    }()
    
    
    /**
     * Share current app.
     */
    open func shareApp() {
        self.manager.shareApp();
    }
    
    /**
     * set the applink.co Code, as received on
     * https://applink.co
     *
     * - Parameter applinkCode: your applink.co code
     */
    open func applinkCode(_ applinkCode: String) {
        self.applinkCode = applinkCode;
        self.manager.applinkCode = applinkCode
    }
    
}

open class AppShareManager : NSObject {
    
    var applinkCode : String?;
    var vc : UIViewController?;

    func shareApp() {
        if let url = getShareURL() {
            let objectsToShare = [url]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            if let vc = self.vc {
                vc.present(activityVC, animated: true, completion: nil)
            }
        }
    }
    
    private func getShareURL() -> URL? {
        if let applinkCode = self.applinkCode {
            let urlString = "https://applink.co/" + applinkCode
            return URL(string: urlString);
        }
        return nil;
    }
    
}
