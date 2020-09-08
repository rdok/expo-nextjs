import React from 'react';
import {Text, Header, ThemeProvider} from 'react-native-elements';

export default function App() {
    return (
        <ThemeProvider>

            <Header
                centerComponent={{ text: 'Expo NextJS Template', style: { color: '#fff' } }}
            />

            <Text h2>Expo NextJS Template</Text>

        </ThemeProvider>
    )
}
