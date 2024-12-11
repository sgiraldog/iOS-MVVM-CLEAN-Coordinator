//
//  AppDelegate+Injection.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//


import Resolver

extension Resolver: ResolverRegistering {
    
    // Container used for preview purposes
    static var preview: Resolver = Resolver(child: .main)
    
    @MainActor
    public static func registerAllServices() {
        register {
            NetworkClient() as NetworkClientProtocol
        }.scope(.shared)
        
        register {
            PeopleService() as PeopleServiceProtocol
        }.scope(.shared)
        
        register {
            PeopleRepository() as PeopleRepositoryProtocol
        }.scope(.shared)
        
        register {
            FetchPeopleUseCase() as FetchPeopleUseCaseProtocol
        }.scope(.shared)
        
        register {
            MainCoordinator()
        }.scope(.application)
    }
}
