//
//  MissionView.swift
//  Moonshot
//
//  Created by Jesus Calleja on 25/11/22.
//  Copyright © 2022 Paul Hudson. All rights reserved.
//

import SwiftUI

struct MissionView: View {

    let mission: Mission
    let crew: [CrewMember]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)

                    Text(mission.formattedLaunchDate)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.top)

                    VStack(alignment: .leading) {

                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)

                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)

                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)

                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                    }
                    .padding(.horizontal)

                    CrewView(crew: crew)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let mission : [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: mission[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
