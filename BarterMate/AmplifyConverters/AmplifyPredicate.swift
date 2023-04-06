////
////  AmplifyPredicate.swift
////  BarterMate
////
////  Created by mark on 4/4/2023.
////
//
//import Foundation
//import Amplify
//
//extension BarterMatePredicate {
//    func toAmplifyQueryPredicate(field: String) -> QueryPredicate {
//        switch self {
//        case let group as BarterMatePredicateGroup:
//            let amplifyPredicates = group.predicates.map { $0.toAmplifyQueryPredicate(field: field) }
//            return QueryPredicateGroup(type: QueryPredicateGroupType(rawValue: group.type.rawValue)!, predicates: amplifyPredicates)
//
//        case let operation as BarterMatePredicateOperation:
//            let amplifyOperator = operation.operator.toAmplifyQueryOperator(field: field)
//            return QueryPredicateOperation(field: operation.field, operator: amplifyOperator)
//
//        default:
//            fatalError("Unsupported BarterMatePredicate type")
//        }
//    }
//}
//
//extension BarterMateQueryOperator {
//    func toAmplifyQueryOperator(field: String) -> QueryOperator {
//        switch self {
//        case .notEqual(let value):
//            return QueryOperator.notEqual(value as? Persistable)
//        case .equals(let value):
//            return QueryOperator.equals(value as? Persistable)
//        case .lessOrEqual(let value):
//            return QueryOperator.lessOrEqual(value as! Persistable)
//        case .lessThan(let value):
//            return QueryOperator.lessThan(value as! Persistable)
//        case .greaterOrEqual(let value):
//            return QueryOperator.greaterOrEqual(value as! Persistable)
//        case .greaterThan(let value):
//            return QueryOperator.greaterThan(value as! Persistable)
//        case .between(let start, let end):
//            return QueryOperator.between(start: start as! Persistable, end: end as! Persistable)
//        case .contains(let value):
//            return QueryOperator.contains(value as! Persistable as! String)
//        case .notContains(let value):
//            return QueryOperator.notContains(value as! Persistable as! String)
//        case .beginsWith(let value):
//            return QueryOperator.beginsWith(value as! Persistable as! String)
//        }
//    }
//}
