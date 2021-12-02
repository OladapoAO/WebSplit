//
//  Settings.swift
//  WebSplit
//
//  Created by Daps Owolabi on 13/11/2021.
//

import Foundation
import UserNotifications


final class NotificationManager: ObservableObject {
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async{
                self.authorizationStatus = settings.authorizationStatus
            }
         }
        }
        
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
           {isGranted, _ in
               DispatchQueue.main.async{
                   self.authorizationStatus = isGranted ? .authorized : .denied
               }
          }
        }
        
    func reloadLocalNotifications() {
        print("reloadLocalNotifications")
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async{
                self.notifications = notifications
            }
          }
        }
    
}
