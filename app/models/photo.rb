class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :trail

  has_attached_file :image,
    styles: {
        large: "500x500#",
        medium: "300x300#",
        thumb: "100x100#"
    },
    convert_options: {
        thumb: "-quality 75 -strip",
        original: "-quality 85 -strip"
    },
    storage: :s3,
    s3_region: AWS_REGION,
    s3_credentials: {
        bucket: S3_BUCKET,
        access_key_id: AWS_ACCESS_KEY_ID,
        secret_access_key: AWS_SECRET_ACCESS_KEY
    },
    default_url: "/images/:style/missing_image.jpg"

    validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

end
