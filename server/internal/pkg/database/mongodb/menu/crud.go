package menustore

import (
	"context"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"server/internal/pkg/database/mongodb"
	dbstructure "server/internal/pkg/database/structure"
)

func CreateMMenu(mMenu *dbstructure.MMenu) error {
	session, err := mongodb.Client.StartSession()
	if err != nil {
		return err
	}
	defer session.EndSession(context.Background())

	callback := func(sc mongo.SessionContext) (interface{}, error) {
		_, err := mongodb.MenuColl.InsertOne(sc, mMenu)
		return nil, err
	}

	_, err = session.WithTransaction(context.Background(), callback)
	return err
}

func GetCategoryList(storeCode string) ([]string, error) {
	filter := bson.M{"store_code": storeCode}
	ctx := context.Background()

	results, err := mongodb.MenuColl.Distinct(ctx, "category", filter)
	if err != nil {
		return nil, err
	}

	var categories []string
	for _, cat := range results {
		if c, ok := cat.(string); ok {
			categories = append(categories, c)
		}
	}

	return categories, nil
}

func GetMMenuList(storeCode string, category string) ([]dbstructure.MMenu, error) {
	filter := bson.M{
		"store_code": storeCode,
		"category":   category,
	}

	cursor, err := mongodb.MenuColl.Find(context.Background(), filter)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(context.Background())

	var menus []dbstructure.MMenu
	for cursor.Next(context.Background()) {
		var menu dbstructure.MMenu
		if err := cursor.Decode(&menu); err != nil {
			return nil, err
		}
		menus = append(menus, menu)
	}

	return menus, nil
}

func GetMMenuDetail(storeCode, category, menu string) (*dbstructure.MMenu, error) {
	filter := bson.M{
		"store_code": storeCode,
		"category":   category,
		"name":       menu,
	}

	var result dbstructure.MMenu
	err := mongodb.MenuColl.FindOne(context.Background(), filter).Decode(&result)
	if err == mongo.ErrNoDocuments {
		return nil, nil
	} else if err != nil {
		return nil, err
	}

	return &result, nil
}

func FindMenuImage(storeCode string, name string) (string, error) {
	filter := bson.M{
		"store_code": storeCode,
		"name":       name,
	}

	var result struct {
		Image string `bson:"image"`
	}

	err := mongodb.MenuColl.FindOne(context.Background(), filter).Decode(&result)
	if err != nil {
		return "", err
	}

	return result.Image, nil
}
