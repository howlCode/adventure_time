import Vue from "vue";
import Router from "vue-router";
import Signin from "@/components/Signin";
import Signup from "@/components/Signup";

import Main from "@/components/Main";
import VotingMain from "@/components/VotingMain";
import Stories from "@/components/Stories";
import StoryArcs from "@/components/StoryArcs";
import StoryForm from "@/components/StoryForm";
import Arc from "@/components/Arc";
import ArcForm from "@/components/ArcForm";

import ForgotPassword from "@/components/ForgotPassword";
import ResetPassword from "@/components/ResetPassword";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: "/",
      name: "Main",
      component: Main
    },
    {
      path: "/stories",
      name: "Stories",
      component: Stories
    },
    {
      path: "/new-arcs",
      name: "VotingMain",
      component: VotingMain
    },
    {
      path: "/signin",
      name: "Signin",
      component: Signin,
      props: true
    },
    {
      path: "/signup",
      name: "Signup",
      component: Signup
    },
    {
      path: "/stories/:id",
      name: "StoryArcs",
      component: StoryArcs
    },
    {
      path: "/stories/:story_id/arcs/:id",
      name: "Arc",
      component: Arc
    },
    {
      path: "/new-story",
      name: "StoryForm",
      component: StoryForm
    },
    {
      path: "/stories/:id/new-arc",
      name: "ArcForm",
      component: ArcForm
    },
    {
      path: "/forgot_password",
      name: "ForgotPassword",
      component: ForgotPassword
    },
    {
      path: "/password_resets/:token",
      name: "ResetPassword",
      component: ResetPassword
    }
  ]
});
