import React, { ButtonHTMLAttributes } from "react";
import styled from "styled-components";

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  fill?: "solid" | "transparent" | "outline";
}

const S = {
  Button: styled.button<ButtonProps>`
    padding: 1rem 2rem;
    border: 0;
    outline: none;
    border-radius: 0.5rem;
    box-sizing: border-box;
    cursor: pointer;
    ${({ theme }) => theme.typography.button};
    background-color: ${({ theme, fill }) =>
      fill === "solid" ? theme.palette.primary : "transparent"};
    width: fit-content;
    color: ${({ theme, fill }) =>
      fill === "solid" ? theme.palette.white : theme.palette.primary};
    border: ${({ theme, fill }) =>
      fill === "solid" ? "none" : `1px solid ${theme.palette.primary}`};
    &:focus {
      outline: none;
    }
  `,
};

const Button: React.FC<ButtonProps> = (props) => <S.Button {...props} />;

export default Button;
