//
//  SignalProducer.swift
//  Core
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import ReactiveSwift
import Result

public extension SignalProducerProtocol {
    
    /**
         Transforms a `SignalProducer<Value, Error>` to `SignalProducer<Value, NewError>`
         This is usually pretty useful when the `flatMap` operator is used and the outer
         producer has `NoError` error type and the inner one a different type of error.
         
         - returns: A signal producer with the same value type but with `NewError` as the error type
     */
    public func liftError<NewError>() -> SignalProducer<Value, NewError> {
        return flatMapError { _ in SignalProducer<Value, NewError>.empty }
    }
    
    /**
         Transforms the `SignalProducer<Value, Error>` to `SignalProducer<Result<Value, Error>, NoError>`.
         This is usually useful when the `flatMap` triggers different producers
         which if failed shouldn't finish the whole result producer, stopping new producers
         from being triggered when a new value arrives at self.
     
         For example,
         ```
         var myProperty: MutableProperty<CLLocation>
     
         myProperty.producer.flatMap(.Latest) { clLocation -> SignalProducer<MyLocation, MyError> in
             return locationService.fetchLocation(clLocation)
         }
         ```
         
         It may be considered similar to the `events` signal of an `Action` (with only next and failed).
     */
    public func toResultSignalProducer() -> SignalProducer<Result<Value, Error>, NoError> {
        return map { Result<Value, Error>.success($0) }
            .flatMapError { error -> SignalProducer<Result<Value, Error>, NoError> in
                let errorValue = Result<Value, Error>.failure(error)
                return SignalProducer<Result<Value, Error>, NoError>(value: errorValue)
        }
    }

    /**
        Filters stream and only passes through the values that respond
        to the specific type, as elements of that specific type.
     
        - returns: A signal producer with value type T and the same error type.
    */
    public func filterType<T>() -> SignalProducer<T, Error> {
        return filter { $0 is T }.map { $0 as! T }  //swiftlint:disable:this force_cast
        //Can't restrict T to conform/inherit-from Value
    }

}

public extension SignalProducerProtocol where Value: OptionalProtocol {

    /**
        Skips all not-nil values, sending only the .none values through.
     */
    public func skipNotNil() -> SignalProducer<Value, Error> {
        return filter { $0.optional == nil }
    }

}

public extension SignalProducerProtocol where Value: ResultProtocol {
    
    /**
         Transforms a `SignalProducer<ResultProtocol<Value2, Error2>, Error>`
         to `SignalProducer<Value2, Error>`, ignoring all `Error2` events.
         
         It may be considered similar to the `values` signal of an `Action`,
         but for producers.
     */
    public func filterValues() -> SignalProducer<Value.Value, Error> {
        return filter {
            if let _ = $0.value {
                return true
            }
            return false
        }.map { $0.value! }
    }
    
    /**
         Transforms a `SignalProducer<ResultProtocol<Value2, Error2>, Error>`
         to `SignalProducer<Error2, Error>`, ignoring all `Value2` events.
         
         It may be considered similar to the `errors` signal of an `Action`,
         but for producers.
     */
    public func filterErrors() -> SignalProducer<Value.Error, Error> {
        return filter {
            if let _ = $0.error {
                return true
            }
            return false
        }.map { $0.error! }
    }
    
}
