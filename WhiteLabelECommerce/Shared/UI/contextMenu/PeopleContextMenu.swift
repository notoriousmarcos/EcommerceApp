//
//  PeopleContextMenu.swift
//  MovieSwift
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct PeopleContextMenu: ConnectedView {
    struct Props {
        let isInFanClub: Binding<Bool>
    }

    let people: Int

    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        let isInFanClub = Binding<Bool>(
            get: { state.peoplesState.fanClub.contains(self.people) },
            set: {
                if !$0 {
                    dispatch(PeopleActions.RemoveFromFanClub(people: self.people))
                } else {
                    dispatch(PeopleActions.AddToFanClub(people: self.people))
                }
            })
        return Props(isInFanClub: isInFanClub)
    }

    func body(props: Props) -> some View {
        VStack {
            Button(action: {
                props.isInFanClub.wrappedValue.toggle()
            }) {
                HStack {
                    Text(props.isInFanClub.wrappedValue ? "Remove from fan club" : "Add to fan club")
                    Image(systemName: props.isInFanClub.wrappedValue ? "star.circle.fill" : "star.circle")
                        .imageScale(.medium)
                }
            }
        }
    }
}

#if DEBUG
struct PeopleContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        PeopleContextMenu(people: 0).environmentObject(sampleStore)
    }
}
#endif
