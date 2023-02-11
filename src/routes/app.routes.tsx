import { createNativeStackNavigator } from '@react-navigation/native-stack'

const { Navigator, Screen } = createNativeStackNavigator();

import Fipe from '../screens/fipe/index'
import Home from '../screens/home/index'

export function AppRoutes(){
  return(
    <Navigator screenOptions={{headerShown: false}}>
      <Screen name='home' component={Home} />
      <Screen name='fipe' component={Fipe} />
    </Navigator>
  )
}