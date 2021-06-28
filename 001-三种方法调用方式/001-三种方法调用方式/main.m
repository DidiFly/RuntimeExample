//
//  main.m
//  001-三种方法调用方式
//
//  Created by zhou on 2021/6/25.
//

#import <Foundation/Foundation.h>
#import "FFPerson.h"
#import "FFBoys.h"
#import <objc/message.h>

//OC层方法调用
void methodCall(void) {
    //给FFPerson分配内存
    FFPerson *person = [FFPerson alloc];
    //调用方法：OC
    [person likeGirls];
    //调用方法：Framework
    [person performSelector:@selector(likeGirls)];
}

//objc_msgSend调用
void objc_msgSendCall(void) {
    //给FFperson分配内存
    FFPerson *person = objc_msgSend(objc_getClass("FFPerson"), sel_registerName("alloc"));
    //调用方法
    objc_msgSend(person, sel_registerName("likeGirls"));
}

//objc_msgSendSuper调用
void objc_msgSendSuperCall(void) {
    //给FFperson分配内存
    FFBoys *boys = objc_msgSend(objc_getClass("FFBoys"), sel_registerName("alloc"));
    //创建objc_super对象
    struct objc_super boysSuper;
    boysSuper.receiver = boys;
    //这里的super_class可以是当前类FFBoys或者FFPerson，这里的super_class只是指定方法的第一查找对象，如果当前对象找不到，将会去父类中查找
//    boysSuper.super_class = objc_getClass("FFBoys");
    boysSuper.super_class = objc_getClass("FFPerson");
    //调用super方法
    objc_msgSendSuper(&boysSuper, sel_registerName("likeGirls"));
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        methodCall();
        
        objc_msgSendCall();
        
        objc_msgSendSuperCall();
    }
    return 0;
}
