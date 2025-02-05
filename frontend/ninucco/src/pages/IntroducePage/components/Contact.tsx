import React from "react";
import styled from "styled-components";

import { Button, TextField } from "../../../components";
import { contactImage } from "../../../assets";
import { useScrollFadeIn } from "../../../hooks";

const S = {
  Wrapper: styled.section`
    width: 100%;
    max-width: 1180px;
    margin: auto;
    padding: 0 0 120px 0;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  `,
  Image: styled.div<{ image: string }>`
    width: 580px;
    height: 580px;
    background: no-repeat center/cover url(${(props) => props.image});
  `,
  TextWrapper: styled.div`
    box-sizing: border-box;
    width: 580px;
    padding-left: 50px;
    display: flex;
    flex-direction: column;
    justify-content: center;
  `,
  Label: styled.p`
    display: inline-block;
    ${({ theme }) => theme.typography.label};
    color: ${({ theme }) => theme.palette.primary};
    margin-bottom: 1rem;
  `,
  Title: styled.h2`
    ${({ theme }) => theme.typography.subtitle};
    color: ${({ theme }) => theme.palette.black};
    margin-bottom: 1rem;
  `,
  Description: styled.p`
    ${({ theme }) => theme.typography.description};
    color: ${({ theme }) => theme.palette.black};
    margin-bottom: 2rem;
  `,
  Form: styled.form`
    display: flex;
    flex-direction: column;
    input {
      margin-bottom: 1rem;
      width: 70%;
    }
    button {
      width: 70%;
    }
  `,
};

const Contact: React.FC = () => {
  const animatedItem: { [key: number]: any } = {
    0: useScrollFadeIn("up", 1, 0),
    1: useScrollFadeIn("up", 1, 0.2),
    2: useScrollFadeIn("up", 1, 0.3),
    3: useScrollFadeIn("up", 1, 0.4),
  };

  return (
    <S.Wrapper>
      <S.Image image={contactImage} />
      <S.TextWrapper>
        <S.Label {...animatedItem[0]}>Contact us</S.Label>
        <S.Title {...animatedItem[1]}>버그 리포트</S.Title>
        <S.Description {...animatedItem[2]}>
          문제가 있다면 해당 메일로 연락 주시면 확인하겠습니다!
        </S.Description>
        <S.Form {...animatedItem[3]}>
          <TextField type="text" placeholder="Name" />
          <TextField type="text" placeholder="Email Address" />
          <TextField type="text" placeholder="내용" />
          <Button fill="solid" type="submit">
            Become a partner
          </Button>
        </S.Form>
      </S.TextWrapper>
    </S.Wrapper>
  );
};

export default Contact;
