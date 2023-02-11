import { useNavigation } from '@react-navigation/native';
import { Text, View, TouchableOpacity } from 'react-native';

export default function Home() {
  const { navigate } = useNavigation();

  return (
    <View className='flex-1 justify-center items-center'>
      <Text>Application description</Text>
      <TouchableOpacity 
        activeOpacity={0.7}
        className='flex-row h-11 px-4 border border-black mt-2 rounded-lg items-center'
        onPress={() => navigate('fipe')}
      >
        <Text>Go to Search</Text>
      </TouchableOpacity>
    </View>
  );
}
