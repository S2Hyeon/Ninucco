import React from "react";
import styled from "styled-components";
import { useScrollCount } from "../../../hooks";

interface FigureItem {
  title: string;
  number: number;
  unit: string;
  description: string;
}

interface StyledComponentsProps {
  theme: {
    palette: {
      background: string;
      white: string;
      secondary: string;
    };
    typography: {
      subtitle: string;
      subheading: string;
      description: string;
    };
  };
}

const S = {
  Background: styled.section<StyledComponentsProps>`
    width: 100%;
    background-color: ${({ theme }) => theme.palette.background};
  `,
  Wrapper: styled.div`
    width: 100%;
    max-width: 1180px;
    margin: auto;
    padding: 100px 0;
  `,
  List: styled.ul`
    display: flex;
  `,
  ListItem: styled.li<StyledComponentsProps>`
    width: 100%;
    padding: 0 2rem;
    text-align: center;
    &:nth-child(2) {
      border: 2px solid ${({ theme }) => theme.palette.white};
      border-top: none;
      border-bottom: none;
    }
  `,
  Number: styled.span<StyledComponentsProps>`
    ${({ theme }) => theme.typography.subtitle};
    color: ${({ theme }) => theme.palette.secondary};
    font-size: 3rem;
    margin-bottom: 1rem;
  `,
  Unit: styled.span<StyledComponentsProps>`
    ${({ theme }) => theme.typography.subtitle};
    color: ${({ theme }) => theme.palette.secondary};
    font-size: 3rem;
    margin-bottom: 1rem;
  `,
  Title: styled.h3<StyledComponentsProps>`
    ${({ theme }) => theme.typography.subheading};
    margin: 1rem 0;
  `,
  Description: styled.p<StyledComponentsProps>`
    ${({ theme }) => theme.typography.description};
  `,
};

const FIGURE_ITEMS: FigureItem[] = [
  {
    title: "Total Projects",
    number: 630,
    unit: "+",
    description: "Ipsum faucibus vitae aliquet nec ullamcorper sit amet risus.",
  },
  {
    title: "Partners",
    number: 124,
    unit: "",
    description:
      "Nisi scelerisque eu ultrices vitae auctor eu augue ut lectus.",
  },
  {
    title: "Business Success",
    number: 92,
    unit: "%",
    description:
      "Porttitor rhoncus dolor purus non enim praesent elementum facilisis.",
  },
];

const Figure: React.FC = () => {
  const countItem: { [key: number]: { ref: React.RefObject<HTMLDivElement> } } =
    {
      0: useScrollCount(630),
      1: useScrollCount(124),
      2: useScrollCount(92),
    };

  return (
    <S.Background>
      <S.Wrapper>
        <S.List>
          {FIGURE_ITEMS.map((item, index) => (
            <S.ListItem key={item.title} theme={undefined}>
              <S.Number ref={countItem[index].ref}>0</S.Number>
              <S.Unit>{item.unit}</S.Unit>
              <S.Title>{item.title}</S.Title>
              <S.Description>{item.description}</S.Description>
            </S.ListItem>
          ))}
        </S.List>
      </S.Wrapper>
    </S.Background>
  );
};

export default Figure;
