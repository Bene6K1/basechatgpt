export interface Parent {
    id: number;
    name: string;
}

export interface heritageProps {
    [key: string]: number | string;
    selected: 'dad' | 'mom' | 'grandparents';
}