package routes

func RegisterRoutes(router *gin.Engine) {
	//	userController := controllers.NewUserController()

	routes := router.Group("/api/v1")
	{
		// User routes
		//routes.GET("/users", controllers.GetUsers)
		routes.POST("/users", controllers.GetUsers)
	}
}
