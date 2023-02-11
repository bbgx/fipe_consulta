import { Text, View } from 'react-native';
import DropDownPicker from 'react-native-dropdown-picker';

interface IDropdownProps{
  label: string;
  isOpen: boolean;
  value: any;
  disabled: boolean;
  items: Array<any>;
  setValue: (value:any) => void;
  setOpen: () => void;
}

export default function Dropdown({label, disabled, isOpen, value, setValue, items, setOpen}: IDropdownProps){
  return(
    <View>
        <Text>{label}</Text>
        <DropDownPicker
          disabled={disabled}
          open={isOpen}
          value={value}
          setValue={setValue}
          items={items}
          setOpen={setOpen}
          style={{
            zIndex: 1,
            backgroundColor: disabled ? "lightgray" : "white"
          
          }}
        />
    </View>
  )
}