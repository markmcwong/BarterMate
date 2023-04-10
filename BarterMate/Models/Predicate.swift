////
////  Predicate.swift
////  BarterMate
////
////  Created by mark on 4/4/2023.
////
//
//import Foundation
//
//protocol BarterMatePredicate: CustomStringConvertible {
////    associatedtype P: Comparable
//    func evaluate(target: any BarterMateModel) -> Bool
//    var description: String { get }
//}
//
//public enum BarterMatePredicateGroupType: String {
//    case and
//    case or
//    case not
//}
//
//func not<Predicate: BarterMatePredicate>(_ predicate: Predicate) -> BarterMatePredicateGroup {
//    return BarterMatePredicateGroup(type: .not, predicates: [predicate])
//}
//
//class BarterMatePredicateGroup : BarterMatePredicate {
//    typealias P = BarterMateModel
//    public internal(set) var type: BarterMatePredicateGroupType
//    public internal(set) var predicates: [any BarterMatePredicate]
//    
//    var description: String {
//            return "BarterMatePredicateGroup(type: \(type.rawValue), predicates: \(predicates.map { $0.description }.joined(separator: ", ")) )"
//    }
//
//    public init(type: BarterMatePredicateGroupType = .and,
//                predicates: [any BarterMatePredicate] = []) {
//        self.type = type
//        self.predicates = predicates
//    }
//
//    public func and(_ predicate: any BarterMatePredicate) -> BarterMatePredicateGroup {
//        if case .and = type {
//            predicates.append(predicate)
//            return self
//        }
//        return BarterMatePredicateGroup(type: .and, predicates: [self, predicate])
//    }
//
//    public func or(_ predicate: any BarterMatePredicate) -> BarterMatePredicateGroup {
//        if case .or = type {
//            predicates.append(predicate)
//            return self
//        }
//        return BarterMatePredicateGroup(type: .or, predicates: [self, predicate])
//    }
//    
//    public static func && (lhs: BarterMatePredicateGroup, rhs: any BarterMatePredicate) -> BarterMatePredicateGroup {
//        return lhs.and(rhs)
//    }
//
//    public static func || (lhs: BarterMatePredicateGroup, rhs: any BarterMatePredicate) -> BarterMatePredicateGroup {
//        return lhs.or(rhs)
//    }
//
//    public static prefix func ! (rhs: BarterMatePredicateGroup) -> BarterMatePredicateGroup {
//        return not(rhs)
//    }
//
//    public func evaluate(target: any P) -> Bool {
//        switch type {
//        case .or:
//            for predicate in predicates {
//                if predicate.evaluate(target: target) {
//                    return true
//                }
//            }
//            return false
//        case .and:
//            for predicate in predicates {
//                if !predicate.evaluate(target: target) {
//                    return false
//                }
//            }
//            return true
//        case .not:
//            let predicate = predicates[0]
//            return !predicate.evaluate(target: target)
//        }
//    }
//}
//
//class BarterMatePredicateOperation: BarterMatePredicate {
//    public let field: String
//    public let `operator`: BarterMateQueryOperator
//    
//    var description: String {
//           return "BarterMatePredicateOperation(field: \(field), operator: \(`operator`.description))"
//   }
//
//    public init(field: String, operator: BarterMateQueryOperator) {
//        self.field = field
//        self.operator = `operator`
//    }
//
//    public func evaluate(target: any BarterMateModel) -> Bool {
////        guard let fieldValue = target[field] else {
////            return false
////        }
//
////        guard let value = target else {
////            return false
////        }
//
//        return self.operator.evaluate(target: target)
//    }
//}
//
//public enum BarterMateQueryOperator {
//    case notEqual(_ value: (any BarterMateModel)?)
//    case equals(_ value:  (any BarterMateModel)?)
//    case lessOrEqual(_ value: any BarterMateModel)
//    case lessThan(_ value: any BarterMateModel)
//    case greaterOrEqual(_ value: any BarterMateModel)
//    case greaterThan(_ value: any BarterMateModel)
//    case contains(_ value: any BarterMateModel)
//    case notContains(_ value: any BarterMateModel)
//    case between(start: any BarterMateModel, end: any BarterMateModel)
//    case beginsWith(_ value: any BarterMateModel)
//    
//    public func evaluate(target: BarterMateModel) -> Bool {
//        switch self {
//        case .notEqual(let predicateValue):
//            //            guard let val = predicateValue else { return false }
//            return !(target == predicateValue)
//        case .equals(let predicateValue):
//            return (target == predicateValue)
//        case .lessOrEqual(let predicateValue):
//            guard type(of: predicateValue) == type(of: target) else {
//                return false
//            }
//            return (target <= (predicateValue))
//        case .lessThan(let predicateValue):
//            return (target < predicateValue)
//        case .greaterOrEqual(let predicateValue):
//            return (target >= predicateValue)
//        case .greaterThan(let predicateValue):
//            return (target > predicateValue)
//        case .contains(let predicateValue):
//            if let targetString = target as? String, let predicateString = predicateValue as? String {
//                return targetString.contains(predicateString)
//            }
//            return false
//        case .notContains(let predicateValue):
//            if let targetString = target as? String, let predicateString = predicateValue as? String {
//                return !targetString.contains(predicateString)
//            }
//            return false
//        case .between(let start, let end):
//            return (end >= target) && (target >= start)
//        case .beginsWith(let predicateValue):
//            if let targetString = target as? String, let predicateString = predicateValue as? String {
//                return targetString.starts(with: predicateString)
//            }
//            return false
//        }
//    }
//    
//    public var description: String {
//        switch self {
//        case .notEqual(let value):
//            return "notEqual(\(String(describing: value)))"
//        case .equals(let value):
//            return "equals(\(String(describing: value)))"
//        case .lessOrEqual(let value):
//            return "lessOrEqual(\(value))"
//        case .lessThan(let value):
//            return "lessThan(\(value))"
//        case .greaterOrEqual(let value):
//            return "greaterOrEqual(\(value))"
//        case .greaterThan(let value):
//            return "greaterThan(\(value))"
//        case .contains(let value):
//            return "contains(\(value))"
//        case .notContains(let value):
//            return "notContains(\(value))"
//        case .between(let start, let end):
//            return "between(\(start), \(end))"
//        case .beginsWith(let value):
//            return "beginsWith(\(value))"
//        }
//    }
//}
