import Vue from "vue";
import Router from "vue-router";
import Signin from "@/components/Signin";
import Signup from "@/components/Signup";
import Stories from "@/components/Stories";
import StoryForm from "@/components/StoryForm";
import UsersList from "@/components/admin/users/List";
import UserStoriesList from "@/components/admin/users/stories/List";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: "/",
      name: "Stories",
      component: Stories
    },
    {
      path: "/signin",
      name: "Signin",
      component: Signin
    },
    {
      path: "/signup",
      name: "Signup",
      component: Signup
    },
    {
      path: "/stories/new",
      name: "StoryForm",
      component: StoryForm
    },
    {
      path: "/admin/users",
      name: "UsersList",
      component: UsersList
    },
    {
      path: "/admin/users/:id/stories",
      name: "UserStoriesList",
      component: UserStoriesList
    }
  ]
});
